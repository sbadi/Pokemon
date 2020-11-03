//
//  Repository.swift
//  Pokemon
//
//  Created by Alberto Bo on 26/10/2020.
//

import Foundation
import RxSwift


class PokemonRepository: DependencyFactory {

    var container: AppDependencyContainer
    let apiManager: APIManager

    init(container: AppDependencyContainer, apiManager: APIManager) {
        self.container = container
        self.apiManager = apiManager
    }

    func getPokemonImage(from url: String, imageId: NSNumber, onCompletion: @escaping (UIImage)->Void) {

        let filename = "\(imageId).png"

        self.apiManager
            .requestImage(from: url, imageId: imageId, onCompletion: { [weak self] image in
                self?.saveImage(fileName: filename, image: image)
                onCompletion(image)
            })
    }

    func getPokemonList(with offset: Int, limit: Int) -> Observable<PokemonListResponseModel> {

        let filename = AppConstants.filename.replacingOccurrences(of: "#", with: "1")

        if PokemonRepository.fileExists(at: "\(filename)") {
            return .just(self.getPokemonOffline(for: filename))
        }

        let pokemonList = self.apiManager
            .request(for: .pokemonList(offset: offset, limit: limit), mapTo: PokemonListResponseModel.self)
            .catchError { [weak self] _ in
                return self?.getPokemonListOffline() ?? .empty()
            }
        
        return self.buildDetails(from: pokemonList)
    }

    func getNextPokemons(from previousResponse: PokemonListResponseModel) -> Observable<PokemonListResponseModel> {

        let currentPage = previousResponse.currentIndex + 1
        let filename = AppConstants.filename.replacingOccurrences(of: "#", with: "\(currentPage)")

        if PokemonRepository.fileExists(at: "\(filename)") {
            return .just(self.getPokemonOffline(for: filename))
        }

        guard let url = previousResponse.next else {
            return .empty()
        }

        let pokemonList = self.apiManager
            .request(from: url, mapTo: PokemonListResponseModel.self)
            .catchError {[weak self]  _ in
                return self?.getPokemonListOffline(from: previousResponse.currentIndex) ?? .empty()
            }
        return self.buildDetails(from: pokemonList)
    }

    private func buildDetails(from response: Observable<PokemonListResponseModel>) -> Observable<PokemonListResponseModel> {

        return response
            .flatMapLatest { response -> Observable<PokemonListResponseModel> in

                if response.previous == nil && response.next == nil {
                    return .just(response)
                }

                let array = response.results
                    .compactMap { [weak self] pokemon -> Observable<PokemonModel> in
                        guard let self = self, let url = pokemon.url else { return .empty() }
                        return self.getPokemonDetails(from: url)
                    }

                let result = Observable.concat(array).toArray().asObservable()
                return result
                    .flatMapLatest { [weak self] pokemonDetails -> Observable<PokemonListResponseModel> in
                        guard let self = self else { return .just(.empty) }
                        var copy = response
                        copy.results = pokemonDetails

                        if let jsonData = try? JSONEncoder().encode(copy) {
                            self.writeJSONToFile(filename: "pokemon_list_\(copy.currentIndex)", data: jsonData)
                        }

                        return .just(copy)
                    }
            }
    }

    private func getPokemonDetails(from url: String) -> Observable<PokemonModel> {
        self.apiManager
            .request(from: url, mapTo: PokemonModel.self)
            .catchErrorJustReturn(PokemonModel.empty)
    }
}

//
//  APIManager.swift
//  Pokemon
//
//  Created by Alberto Bo on 26/10/2020.
//

import Foundation
import RxSwift

class APIManager: NSObject, URLSessionTaskDelegate, URLSessionDelegate, URLSessionDataDelegate {

    var apiVersion: String = "v2"
    var baseURL: String = "https://pokeapi.co/api/"
    var imageCache: ImageCache = ImageCache(config: .defaultConfig)

    lazy var session: URLSession = {
        URLSession(configuration: .default, delegate: self, delegateQueue: .main)
    }()


    func request<T: Decodable>(for api: API, mapTo: T.Type) -> Observable<T> {

        guard var components = URLComponents(string: self.baseURL + self.apiVersion + api.path) else {
            return .error(PokemonError.genericError(-1))
        }
        components.queryItems = api
            .parameters
            .map { key, value in
                URLQueryItem(name: key, value: String(describing: value))
            }

        guard let url = components.url else {
            return .error(PokemonError.genericError(-1))
        }
        var request = URLRequest(url: url)
        request.httpMethod = api.method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        return session.rx.response(to: request)
            .compactMap { data in
                let jsonDecoder = JSONDecoder()
                return try? jsonDecoder.decode(T.self, from: data)
            }

    }

    func request<T: Decodable>(from url: String, mapTo: T.Type) -> Observable<T> {

        guard let url = URL(string: url) else {
            return .error(PokemonError.genericError(-1))
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return session.rx.response(to: request)
            .compactMap { data in
                let jsonDecoder = JSONDecoder()
                return try? jsonDecoder.decode(T.self, from: data)
            }
    }

    func requestImage(from url: String, imageId: NSNumber, onCompletion: @escaping (UIImage)-> Void) {

        if let image = self.imageCache.getCachedImage(for: imageId) {  onCompletion(image)
            return
        }

        let filename = "\(imageId).png"
        if let image = PokemonRepository.getImage(filename: filename) {
            onCompletion(image)
            return
        }

        guard let url = URL(string: url) else {
            onCompletion(AppImages.pokemonLogo.image)
            return
        }

        let request = URLRequest(url: url)
        let task = self.session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self,
                  let data = data,
                  let response = response as? HTTPURLResponse,
                  (200 ..< 300) ~=  response.statusCode,
                  error == nil else {
                onCompletion(AppImages.pokemonLogo.image)
                return
            }

            guard let image = UIImage(data: data) else {
                onCompletion(AppImages.pokemonLogo.image)
                return
            }
            
            self.imageCache.insertImage(image, for: imageId)
            onCompletion(image)

        }
        task.resume()
    }
}

extension Reactive where Base: URLSession {

    func response(to request: URLRequest) -> Observable<Data> {

        return Observable.create { observer in
            let task = self.base.dataTask(with: request) { data, response, error in
                guard let data = data,
                      let response = response as? HTTPURLResponse,
                      (200 ..< 300) ~=  response.statusCode,
                      error == nil else {
                    observer.on(.error(PokemonError.genericError(-1)))
                    return
                }
                observer.on(.next(data))
                observer.on(.completed)
            }
            task.resume()
            return Disposables.create(with: task.cancel)
        }
    }
}

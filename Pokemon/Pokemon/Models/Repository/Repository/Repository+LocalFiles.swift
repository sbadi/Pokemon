//
//  Repository+LocalFiles.swift
//  Pokemon
//
//  Created by Alberto Bo on 01/11/2020.
//

import Foundation
import RxSwift

extension PokemonRepository {

    func saveImage(fileName: String, image: UIImage) {

        guard let filePath = PokemonRepository.getFilePath(path: fileName) else {
            return
        }

        if !PokemonRepository.fileExists(at: fileName) {
            if let pngData = image.pngData() {
                do {
                    try pngData.write(to: filePath)
                } catch {
                    print("error saving file:", error)
                }
            }
        }
    }

    static func getImage(filename: String) -> UIImage? {

        guard let filePath = self.getFilePath(path: filename) else {
            return nil
        }

        if PokemonRepository.fileExists(at: filename) {
            return UIImage(contentsOfFile: filePath.path)
        }
        return nil
    }

    func writeJSONToFile(filename: String, data: Data) {

        if !PokemonRepository.fileExists(at: filename),
           let jsonString = String(data: data, encoding: .utf8),
           let documentDirectory = FileManager.default
            .urls(for: .documentDirectory,in: .userDomainMask)
            .first {
            print("jsonString \(jsonString)")

            let pathWithFileName = documentDirectory.appendingPathComponent("\(filename).json")
            do {
                try data.write(to: pathWithFileName)
            } catch {
                print("error while writing file")
            }
        }
    }

    static func getFilePath(path: String) -> URL? {
        guard let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            return nil
        }

        let url = NSURL(fileURLWithPath: documentPath)
        guard let pathComponent = url.appendingPathComponent(path) else {
            return nil
        }
        return pathComponent
    }

    static func fileExists(at path: String) -> Bool {

        guard let filePath = PokemonRepository.getFilePath(path: path) else {
            return false
        }

        let exist = FileManager.default.fileExists(atPath: filePath.path)
        return exist
    }


    func getPokemonOffline(for path: String) -> PokemonListResponseModel {

        guard let finalPath = PokemonRepository.getFilePath(path: path) else {
            return .empty
        }
        do {

            let jsonDecoder = JSONDecoder()

            guard let jsonData = try? String(contentsOfFile: finalPath.path).data(using: .utf8),
                  let response = try? jsonDecoder.decode(PokemonListResponseModel.self, from: jsonData)
            else {
                return .empty
            }

           return response
        }
    }

    func getPokemonListOffline(from currentPage: Int? = nil) -> Observable<PokemonListResponseModel> {

        if let path = Bundle.main.path(forResource: "pokemon", ofType: "json") {

            let fileUrl = URL(fileURLWithPath: path)

            let jsonDecoder = JSONDecoder()

            guard let jsonData = try? String(contentsOfFile: fileUrl.path).data(using: .utf8),
            var response = try? jsonDecoder.decode(PokemonListResponseModel.self, from: jsonData) else {
                return .just(.empty)
                }

            if let current = currentPage {
                let trimmedList: [PokemonModel] = Array(response.results.dropFirst(current * AppConstants.pokemonPerPage))
                response.results = trimmedList
            }
            return .just(response)
        }
        return .just(.empty)
    }
}

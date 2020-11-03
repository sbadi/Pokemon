//
//  PokemonListResponseModel.swift
//  Pokemon
//
//  Created by Alberto Bo on 26/10/2020.
//

import Foundation

struct AppConstants {
    static let pokemonPerPage: Int = 15
    static let filename = "pokemon_list_#.json"
}

struct PokemonListResponseModel: ModelType {

    static var empty: PokemonListResponseModel { PokemonListResponseModel() }

    var count: Int?
    var previous: String?
    var next: String?
    var results: [PokemonModel] = []

    var currentIndex: Int {
        if let nextComps = next?.components(separatedBy: "offset=")
           , let i = nextComps.last?.components(separatedBy: "&").first, var index = Int(i) {
            index = index == 0 ? 0 : (index / AppConstants.pokemonPerPage)
            return index
        }
        return 0
    }

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case previous = "previous"
        case next = "next"
        case results = "results"
    }

    init() {}
}

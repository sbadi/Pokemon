//
//  PokemonModel.swift
//  Pokemon
//
//  Created by Alberto Bo on 26/10/2020.
//

import Foundation
struct PokemonModel: ModelType {

    var name: String?
    var url: String?
    var pokemonId: Int?
    var baseExperience: Int?
    var height: Int?
    var weight: Int?
    var order: Int?
    var images: ImagesModel?
    var moves: [MovesModel]?
    var abilities: [AbilitiesModel]?
    var types: [TypesModel]?
    var stats: [StatsModel]?

    static var empty: PokemonModel = { PokemonModel() }()

    var size: String? {
        guard let height = height, let weight = weight else { return nil }
        let kg = Double(Double(weight) * 0.45359237).round(to: 1)
        let m =  Double(Double(height) * 0.3048).round(to: 1)
        return "\(kg) x \(m)"
    }

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
        case pokemonId = "id"
        case baseExperience = "base_experience"
        case height = "height"
        case weight = "weight"
        case order = "order"
        case images = "sprites"
        case moves = "moves"
        case abilities = "abilities"
        case types = "types"
        case stats = "stats"
    }
}

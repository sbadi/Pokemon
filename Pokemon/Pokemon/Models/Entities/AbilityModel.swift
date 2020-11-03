//
//  AbilityModel.swift
//  Pokemon
//
//  Created by Alberto Bo on 29/10/2020.
//

import Foundation

struct AbilitiesModel: ModelType {

    var ability: AbilityModel?
    enum CodingKeys: String, CodingKey {
        case ability = "ability"
    }
}

struct AbilityModel: ModelType {

    var name: String? 

    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}

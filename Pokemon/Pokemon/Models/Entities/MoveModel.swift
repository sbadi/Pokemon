//
//  MoveModel.swift
//  Pokemon
//
//  Created by Alberto Bo on 29/10/2020.
//


struct MovesModel: ModelType {

    var move: MoveModel?
    enum CodingKeys: String, CodingKey {
        case move = "move"
    }
}

struct MoveModel: ModelType {

    var name: String?
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}

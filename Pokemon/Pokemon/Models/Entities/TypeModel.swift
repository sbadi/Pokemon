//
//  TypeModel.swift
//  Pokemon
//
//  Created by Alberto Bo on 29/10/2020.
//

import Foundation

struct TypesModel: ModelType {

    var type: TypeModel?
    enum CodingKeys: String, CodingKey {
        case type = "type"
    }
}

struct TypeModel: ModelType {

    var name: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}

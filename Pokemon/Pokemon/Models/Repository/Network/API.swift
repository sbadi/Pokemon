//
//  API.swift
//  Pokemon
//
//  Created by Alberto Bo on 26/10/2020.
//

import Foundation


enum API {

    case pokemonList(offset: Int, limit: Int)

    var path: String {

        switch self {

        case .pokemonList:
            return "/pokemon"
        }
    }

    var method: String {
        switch self {
            default: return "GET"
        }
    }

    var parameters: [String : Any] {

        switch self {
        case .pokemonList(let offset, let limit):

            return ["offset": offset,
                    "limit": limit]
        }
    }

    var headers: [String: String]? {
        return nil
    }
}

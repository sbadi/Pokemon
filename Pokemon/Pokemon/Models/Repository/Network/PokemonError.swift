//
//  PokemonError.swift
//  Pokemon
//
//  Created by Alberto Bo on 26/10/2020.
//

import Foundation
import RxSwift

enum PokemonError: Error {

    case genericError(Int)

    var statusCode: Int {
        switch self {
        case .genericError(let statusCode):
            return statusCode
        }
    }
}

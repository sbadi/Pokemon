//
//  PokemonItemViewModel.swift
//  Pokemon
//
//  Created by Alberto Bo on 26/10/2020.
//

import Foundation
import UIKit
import RxSwift

protocol WithImage {
    var imageId: NSNumber { get set }
    func downloadImage(onCompletion: @escaping (UIImage)->Void)
}

class PokemonItemViewModel: ItemViewModelType, WithImage {

    var cellIdentifiers: ItemViewIdentifiers { .pokemon }

    var pokemonName: String? { pokemon.name?.sanitized }
    let pokemon: PokemonModel
    let repository: PokemonRepository

    var imageId: NSNumber

    init(repository: PokemonRepository,
        pokemon: PokemonModel) {
        self.repository = repository
        self.pokemon = pokemon
        imageId = NSNumber(value: pokemon.pokemonId ?? -1)
    }

    func downloadImage(onCompletion: @escaping (UIImage)->Void) {

        if let imageUrl = pokemon.images?.officialArtwork {
            repository.getPokemonImage(from: imageUrl, imageId: imageId, onCompletion: onCompletion)
        } else {
            onCompletion(AppImages.pokemonLogo.image)
        }
    }
}

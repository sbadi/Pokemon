//
//  ItemViewModelFactory.swift
//  Pokemon
//
//  Created by Alberto Bo on 27/10/2020.
//

import Foundation
import UIKit


enum ItemViewIdentifiers: String, CaseIterable, Identifiable {

    case keyValue
    case loadMore
    case pokemon
    case separator
    case simpleImage
    case simpleLabel

    var viewModelName: String {
        let identifier = self.rawValue
        return identifier.prefix(1).uppercased() + identifier.dropFirst() + "ItemViewModel"
    }
    
    var viewName: String {
        let identifier = self.rawValue
        return identifier.prefix(1).uppercased() + identifier.dropFirst() + "ItemView"
    }
}

struct ItemViewFactory: DependencyFactory {

    var container: AppDependencyContainer

    func pokemonList(with pokemon: PokemonModel) -> PokemonItemViewModel {
        if let repo = container.repository {
            return PokemonItemViewModel(repository: repo, pokemon: pokemon)
        }
        fatalError("Dependency Injection error")
    }

    func simpleImage(url: String, imageId: NSNumber) -> SimpleImageItemViewModel {
        if let repo = container.repository {
            return SimpleImageItemViewModel(repository: repo, url: url, imageId: imageId)
        }
        fatalError("Dependency Injection error")
    }

    func showMore(with currentResponse: PokemonListResponseModel) -> LoadMoreItemViewModel {
        LoadMoreItemViewModel(currentResponse: currentResponse)
    }

    func separator() -> SeparatorItemViewModel {
        SeparatorItemViewModel()
    }

    func keyValue(key: String, value: String) -> KeyValueItemViewModel {
        KeyValueItemViewModel(key: key, value: value)
    }

    func simpleLabel(string: String, style: TextStyle, hasBorder: Bool) -> SimpleLabelItemViewModel {
        SimpleLabelItemViewModel(string: string, style: style, hasBorder: hasBorder)
    }


}


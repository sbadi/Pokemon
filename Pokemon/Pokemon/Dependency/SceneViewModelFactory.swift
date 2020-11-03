//
//  SceneViewModelFactory.swift
//  Pokemon
//
//  Created by Alberto Bo on 27/10/2020.
//

import Foundation


enum SceneViewModelIdentifiers: String, CaseIterable, Identifiable {

    case pokemonDetails
    case pokemonList
    case splash

    var viewName: String {
        let identifier = self.rawValue
        return identifier.prefix(1).uppercased() + identifier.dropFirst() + "ViewController"
    }

    var viewModelName: String {
        let identifier = self.rawValue
        return identifier.prefix(1).uppercased() + identifier.dropFirst() + "ViewModel"
    }
}


struct SceneViewModelFactory: DependencyFactory {

    var container: AppDependencyContainer

    func pokemonDetails(for pokemon: PokemonModel) -> PokemonDetailsViewModel {
        if let repository = container.repository, let itemViewModelFactory = container.itemViewFactory  {
            return PokemonDetailsViewModel(pokemon: pokemon, repository: repository, itemViewModelFactory: itemViewModelFactory)
        }
        fatalError("Dependency injection error")

    }
    func pokemonList() -> PokemonListViewModel {
        if let repository = container.repository, let itemViewModelFactory = container.itemViewFactory  {
            return PokemonListViewModel(repository: repository, itemViewModelFactory: itemViewModelFactory)
        }
        fatalError("Dependency injection error")
    }

//    func splash() -> SplashViewModel {
//        if let repository = container.repository  {
//            return SplashViewModel(repository: repository)
//        }
//        fatalError("Dependency injection error")
//    }

}

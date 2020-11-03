//
//  DependencyContainer.swift
//  Pokemon
//
//  Created by Alberto Bo on 27/10/2020.
//


import Foundation

protocol DependencyFactory {
    var container: AppDependencyContainer { get set }
}

class AppDependencyContainer {

    static let shared: AppDependencyContainer = AppDependencyContainer()

    var managers: [String : DependencyFactory] = [:]

    var sceneViewModelFactory: SceneViewModelFactory? {
        return managers[DependencyKey.sceneViewModelFactory.key] as? SceneViewModelFactory
    }

    var viewControllerFactory: ViewControllerFactory? {
        return managers[DependencyKey.viewControllerFactory.key] as? ViewControllerFactory
    }

    var repository: PokemonRepository? {
        return managers[DependencyKey.repository.key] as? PokemonRepository
    }

    var itemViewFactory: ItemViewFactory? {
        return managers[DependencyKey.itemViewFactory.key] as? ItemViewFactory
    }


    enum DependencyKey: String, CaseIterable, Hashable {
        case sceneViewModelFactory = "sceneViewModelFactory"
        case viewControllerFactory = "viewControllerFactory"
        case repository = "repository"
        case itemViewFactory = "itemViewFactory"
        var key: String { return self.rawValue}
    }

    init() {
        
        for key in DependencyKey.allCases {
            switch key {
            case .sceneViewModelFactory:
                managers[key.rawValue] = SceneViewModelFactory(container: self)

            case .viewControllerFactory:
                managers[key.rawValue] = ViewControllerFactory(container: self)

            case .repository:
            managers[key.rawValue] = PokemonRepository(container: self, apiManager: APIManager())

            case .itemViewFactory:
                managers[key.rawValue] = ItemViewFactory(container: self)
            }
        }
    }
}

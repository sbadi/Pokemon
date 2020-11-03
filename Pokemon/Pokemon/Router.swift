//
//  Router.swift
//  Pokemon
//
//  Created by Alberto Bo on 27/10/2020.
//

import UIKit


protocol Router {

    var window: UIWindow? { get set }
    var dependencyContainer: AppDependencyContainer { get set }
    func startApplication()
    func showPokemonDetails(for pokemon: PokemonModel, from: UIViewController)
}

extension Router {

    func showPokemonDetails(for pokemon: PokemonModel, from scene: UIViewController) {

        guard let pokemonDetailsViewModel = self.dependencyContainer.sceneViewModelFactory?.pokemonDetails(for: pokemon), let viewController = self.dependencyContainer.viewControllerFactory?.list(viewModel: pokemonDetailsViewModel) else {
            fatalError("Dependency injection error")
        }

        scene.navigationController?.pushViewController(viewController, animated: true)
    }

    func startApplication() {

        guard let pokemonListViewModel = self.dependencyContainer.sceneViewModelFactory?.pokemonList(), let viewController = self.dependencyContainer.viewControllerFactory?.list(viewModel: pokemonListViewModel) else {
            fatalError("Dependency injection error")
        }

        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.tintColor = .label
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
    }
}

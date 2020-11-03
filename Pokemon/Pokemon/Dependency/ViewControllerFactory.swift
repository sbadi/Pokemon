//
//  ViewControllerFactory.swift
//  Pokemon
//
//  Created by Alberto Bo on 27/10/2020.
//


import Foundation
import UIKit


struct ViewControllerFactory: DependencyFactory {

    var container: AppDependencyContainer

//    func splash() -> UIViewController {
//
//        if let splashViewModel = container.sceneViewModelFactory?.splash() {
//            return SplashViewController(viewModel: splashViewModel)
//        }
//        fatalError("Dependency injection error")
//    }

    func list(viewModel: ListViewModelType) -> UIViewController {
        return ListViewController(viewModel: viewModel)
    }
}


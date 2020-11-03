//
//  PokemonTests.swift
//  PokemonTests
//
//  Created by Alberto Bo on 02/11/2020.
//

import XCTest
@testable import Pokemon

class PokemonTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testPokemonNameSanitized() {

        let pokemon = PokemonModel(name: "pokemon-test-model")

        XCTAssertTrue("Pokemon test model" == pokemon.name?.sanitized, "sanitized extension on string")
    }

    func testDependencies() {
        let dependecyContainer = AppDependencyContainer.shared
        AppDependencyContainer.DependencyKey.allCases.forEach { key in
            XCTAssertNoThrow(dependecyContainer.managers[key.key], "\(key.key) is missing in dependencies container")
        }
    }

    func testItemViewModels() {

        let dependecyContainer = AppDependencyContainer.shared
        XCTAssertNoThrow(dependecyContainer.itemViewFactory)

        let itemViewFactory = dependecyContainer.itemViewFactory
        XCTAssertNoThrow(itemViewFactory?.pokemonList(with: PokemonModel()), "PokemonItemViewModel is missing in dependency container")
        XCTAssertNoThrow(itemViewFactory?.simpleImage(url: "", imageId: NSNumber()), "SimpleImageItemViewModel is missing in dependency container")
    }

    func testSceneViewModels() {

        let dependecyContainer = AppDependencyContainer.shared
        XCTAssertNoThrow(dependecyContainer.sceneViewModelFactory)

        let sceneViewModelFactory = dependecyContainer.sceneViewModelFactory
        XCTAssertNoThrow(sceneViewModelFactory?.pokemonList(), "PokemonListViewModel is missing in dependency container")
        XCTAssertNoThrow(sceneViewModelFactory?.pokemonDetails(for: PokemonModel()), "PokemonDetailsViewModel is missing in dependency container")
    }
}

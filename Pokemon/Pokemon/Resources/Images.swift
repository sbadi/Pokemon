//
//  Images.swift
//  Pokemon
//
//  Created by Alberto Bo on 26/10/2020.
//



import UIKit

enum AppImages: String, CaseIterable {

    case pokemonLogo = "pokemon_logo"

    var image: UIImage {
        UIImage(named: rawValue)!
    }
}

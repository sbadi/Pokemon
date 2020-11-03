//
//  SimpleImageItemViewModel.swift
//  Pokemon
//
//  Created by Alberto Bo on 29/10/2020.
//



import Foundation
import UIKit
import RxSwift

class SimpleImageItemViewModel: ItemViewModelType, WithImage {

    var cellHeight: CGFloat? {
        min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    }

    var cellIdentifiers: ItemViewIdentifiers { .simpleImage }
    var imageId: NSNumber
    let url: String
    let repository: PokemonRepository

    init(repository: PokemonRepository, url: String, imageId: NSNumber) {

        self.repository = repository
        self.imageId = imageId
        self.url = url
    }

    func downloadImage(onCompletion: @escaping (UIImage) -> Void) {
        repository
            .getPokemonImage(from: url, imageId: imageId, onCompletion: onCompletion)
    }

}

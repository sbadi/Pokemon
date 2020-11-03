//
//  LoadMoreItemViewModel.swift
//  Pokemon
//
//  Created by Alberto Bo on 26/10/2020.
//

import Foundation
import CoreGraphics

class LoadMoreItemViewModel: ItemViewModelType {
    
    var cellHeight: CGFloat? { 52.0 }
    var cellIdentifiers: ItemViewIdentifiers { .loadMore }

    let buttonTitle: String = "Load more"

    var url: String { currentResponse.next ?? "" }

    let currentResponse: PokemonListResponseModel

    init(currentResponse: PokemonListResponseModel) {
        self.currentResponse = currentResponse
    }
}

//
//  KeyValueItemViewModel.swift
//  Pokemon
//
//  Created by Alberto Bo on 29/10/2020.
//

import Foundation
import CoreGraphics

class KeyValueItemViewModel: ItemViewModelType {

    var cellHeight: CGFloat? { 52.0 }
    var cellIdentifiers: ItemViewIdentifiers { .keyValue }
    let key: String
    let value: String
    
    init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}

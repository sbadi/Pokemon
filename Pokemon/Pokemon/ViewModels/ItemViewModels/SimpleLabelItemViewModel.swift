//
//  SimpleLabelItemViewModel.swift
//  Pokemon
//
//  Created by Alberto Bo on 29/10/2020.
//


import Foundation
import UIKit

class SimpleLabelItemViewModel: ItemViewModelType {

    var cellHeight: CGFloat? { 52.0 }
    var cellIdentifiers: ItemViewIdentifiers { .simpleLabel }

    let string: String
    let style: TextStyle
    let hasBorder: Bool 

    init(string: String, style: TextStyle, hasBorder: Bool) {
        self.string = string
        self.style = style
        self.hasBorder = hasBorder
    }
}

//
//  SeparatorItemViewModel.swift
//  Pokemon
//
//  Created by Alberto Bo on 30/10/2020.
//


import Foundation
import UIKit

class SeparatorItemViewModel: ItemViewModelType {

    var cellHeight: CGFloat? { 1.0 }
    var cellIdentifiers: ItemViewIdentifiers { .separator }
    init() {}
}

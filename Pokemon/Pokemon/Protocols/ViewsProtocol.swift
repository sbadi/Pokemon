//
//  ViewModelType.swift
//  Pokemon
//
//  Created by Alberto Bo on 26/10/2020.
//

import Foundation
import UIKit

protocol ViewType {
    func bind(with viewModel: ItemViewModelType)
}

protocol Layoutable {
    func setLayout()
    func setStyle()
}

protocol ItemViewModelType {
    var cellIdentifiers: ItemViewIdentifiers { get }
    var cellHeight: CGFloat? { get }
}

extension ItemViewModelType {
    var cellHeight: CGFloat? { nil }
}





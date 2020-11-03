//
//  Styles.swift
//  Pokemon
//
//  Created by Alberto Bo on 30/10/2020.
//

import UIKit


extension UILabel {

    func apply(style: TextStyle) {

        self.font = style.font
        self.textAlignment = style.alignment
        self.textColor = style.textColor
        self.numberOfLines = style.lines
        self.lineBreakMode = .byTruncatingTail
        self.adjustsFontForContentSizeCategory = true

    }
}

enum TextStyle: String, CaseIterable {

    case navigationHeader
    case pokemonList
    case keyLabel
    case valueLabel
    case header
    case propertyLabel
    case statLabel

    var font: UIFont? {
        switch self {
        case .keyLabel:
            return UIFont(name: "Roboto-Regular", size: 16)
        case .header:
            return UIFont(name: "Roboto-Bold", size: 16)
        case .navigationHeader:
            return UIFont(name: "Roboto-Regular", size: 14)
        case .pokemonList:
            return UIFont(name: "Roboto-Bold", size: 14)
        case .valueLabel:
            return UIFont(name: "Roboto-Bold", size: 16)
        case .propertyLabel:
            return UIFont(name: "Roboto-Regular", size: 12)
        case .statLabel:
            return UIFont(name: "Roboto-Bold", size: 16)
        }
    }

    var textColor: UIColor {
        return .label
    }

    var alignment: NSTextAlignment {
        switch self {
        case .keyLabel: return .left
        case .header: return .left
        case .navigationHeader: return .center
        case .pokemonList: return .center
        case .valueLabel: return .right
        case .propertyLabel: return .center
        case .statLabel: return .center
        }
    }

    var lines: Int {
        switch self {
        case .propertyLabel: return 1
        default: return 0
        }
    }

    var identifier: String {
        return rawValue
    }
}


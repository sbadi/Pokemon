//
//  Colors.swift
//  Pokemon
//
//  Created by Alberto Bo on 24/10/2020.
//

import UIKit

extension UIColor {

    static var label: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return .white
                }
                return UIColor(red: 0x28 / 255.0, green: 0x32 / 255.0, blue: 0x37 / 255.0, alpha: 1.0)
            }
        }
        return UIColor(red: 0x28 / 255.0, green: 0x32 / 255.0, blue: 0x37 / 255.0, alpha: 1.0)
    }()

    static var background: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return UIColor(red: 0x28 / 255.0, green: 0x32 / 255.0, blue: 0x37 / 255.0, alpha: 1.0)
                }
                return .white
            }
        }
        return .white
    }()

    static var separator: UIColor = { .label }()

}

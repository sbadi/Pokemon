//
//  SimpleImageItemView+Layout.swift
//  Pokemon
//
//  Created by Alberto Bo on 30/10/2020.
//
import UIKit

extension SimpleImageItemView: Layoutable {

    func setLayout() {

        for view in contentView.subviews {
            view.removeFromSuperview()
        }

        image.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(image)
        image.contentMode = .scaleAspectFit

        let constraints = [
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6.0),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6.0),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6.0),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6.0),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

    func setStyle() { }
}

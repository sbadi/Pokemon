//
//  SeparatorItemView+Layout.swift
//  Pokemon
//
//  Created by Alberto Bo on 30/10/2020.
//

import UIKit

extension SeparatorItemView: Layoutable {

    func setLayout() {

        for view in contentView.subviews {
            view.removeFromSuperview()
        }

        separator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(separator)

        let constraints = [
            separator.topAnchor.constraint(equalTo: contentView.topAnchor),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func setStyle() {
        separator.backgroundColor = .separator
    }

    override func layoutSubviews() {
        setStyle()
        super.layoutSubviews()
    }
}

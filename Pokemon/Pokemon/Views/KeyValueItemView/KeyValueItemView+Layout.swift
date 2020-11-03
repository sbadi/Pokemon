//
//  KeyValueItemView+Layout.swift
//  Pokemon
//
//  Created by Alberto Bo on 29/10/2020.
//



import UIKit

extension KeyValueItemView: Layoutable {

    func setLayout() {

        for view in contentView.subviews {
            view.removeFromSuperview()
        }

        keyLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(keyLabel)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(valueLabel)

        let constraints = [
            
            keyLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 5),
            keyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            keyLabel.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -5.0),

            valueLabel.centerYAnchor.constraint(equalTo: keyLabel.centerYAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            keyLabel.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: 5),

            keyLabel.widthAnchor.constraint(equalTo: valueLabel.widthAnchor, multiplier: 0.6)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func setStyle() {
        self.keyLabel.apply(style: .keyLabel)
        self.valueLabel.apply(style: .valueLabel)
    }

    override func layoutSubviews() {
        setStyle()
        super.layoutSubviews()
    }

}

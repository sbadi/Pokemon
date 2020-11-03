//
//  SimpleLabelItemView+Layout.swift
//  Pokemon
//
//  Created by Alberto Bo on 29/10/2020.
//


import UIKit

extension SimpleLabelItemView: Layoutable {

    func setLayout() {
        for view in contentView.subviews {
            view.removeFromSuperview()
        }

        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)

        let constraints = [
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func setStyle() {
        contentView.layer.cornerRadius = 8.0
        if #available(iOS 13.0, *) {
            let current = UITraitCollection.current
            contentView.layer.borderColor = UIColor.label.resolvedColor(with: current).cgColor
        } else {
            contentView.layer.borderColor = UIColor.separator.cgColor
        }
    }

    override func layoutSubviews() {
        setStyle()
        super.layoutSubviews()
    }

}

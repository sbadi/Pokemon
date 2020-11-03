//
//  LoadMoreItemView+Layout.swift
//  Pokemon
//
//  Created by Alberto Bo on 28/10/2020.
//

import Foundation
import UIKit

extension LoadMoreItemView: Layoutable {

    func setLayout() {

        for view in contentView.subviews {
            view.removeFromSuperview()
        }
        self.drawFakeButton()
    }


    private func drawFakeButton() {

        contentView.autoresizesSubviews = false
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(buttonView)
        buttonView.addSubview(buttonLabel)

        let constraints = [

            buttonView.topAnchor.constraint(equalTo: contentView.topAnchor),
            buttonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            buttonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            buttonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            buttonLabel.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
            buttonLabel.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: 12.0),
            buttonLabel.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor, constant: -12.0)

        ]
        NSLayoutConstraint.activate(constraints)

    }

    func setStyle() {
        buttonLabel.apply(style: .navigationHeader)
    }

    override func layoutSubviews() {
        setStyle()
        super.layoutSubviews()
    }
}

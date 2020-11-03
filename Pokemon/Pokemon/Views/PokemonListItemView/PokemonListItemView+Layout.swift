//
//  PokemonItemView+Layout.swift
//  Pokemon
//
//  Created by Alberto Bo on 26/10/2020.
//


import UIKit

extension PokemonItemView: Layoutable {

    func setLayout() {

        for view in contentView.subviews {
            view.removeFromSuperview()
        }

        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        pokemonImage.translatesAutoresizingMaskIntoConstraints = false
        pokemonNameLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonImage.image = AppImages.pokemonLogo.image
        contentView.addSubview(imageContainer)
        imageContainer.addSubview(pokemonImage)
        contentView.addSubview(pokemonNameLabel)

        contentView.bringSubviewToFront(pokemonNameLabel)

        imageContainer.clipsToBounds = true
        pokemonImage.contentMode = .scaleAspectFit


        let constraints = [
            imageContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageContainer.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24.0),
            imageContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            pokemonImage.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            pokemonImage.leftAnchor.constraint(equalTo: imageContainer.leftAnchor),
            pokemonImage.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),
            pokemonImage.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),

            pokemonNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            pokemonNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            pokemonNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)

        ]

        NSLayoutConstraint.activate(constraints)
    }

    func setStyle() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 6.0
        pokemonNameLabel.apply(style: .pokemonList)
        contentView.layer.cornerRadius = 8.0
        contentView.layer.borderWidth = 2.0
        contentView.layer.cornerRadius = 8.0
        if #available(iOS 13.0, *) {
            let current = UITraitCollection.current
            contentView.layer.borderColor = UIColor.label.resolvedColor(with: current).cgColor
        } else {
            contentView.layer.borderColor = UIColor.label.cgColor
        }
    }

    override func layoutSubviews() {
        setStyle()
        super.layoutSubviews()
    }

}


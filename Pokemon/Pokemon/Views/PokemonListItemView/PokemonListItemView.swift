//
//  PokemonItemView.swift
//  Pokemon
//
//  Created by Alberto Bo on 26/10/2020.
//

import UIKit
import RxSwift


protocol CellWithImage {
    var imageView: UIImageView {get}
}

class PokemonItemView: UICollectionViewCell, ViewType, CellWithImage {

    override var reuseIdentifier: String? { ItemViewIdentifiers.pokemon.viewName }

    var imageView: UIImageView {  pokemonImage  }
    let imageContainer: UIView = UIView(frame: .zero)
    let pokemonImage: UIImageView = UIImageView(frame: .zero)
    let pokemonNameLabel: UILabel = UILabel(frame: .zero)
    let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    func bind(with viewModel: ItemViewModelType) {
        guard let viewModel = viewModel as? PokemonItemViewModel else { return }
        self.pokemonNameLabel.text = viewModel.pokemonName
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image =  AppImages.pokemonLogo.image
    }
}


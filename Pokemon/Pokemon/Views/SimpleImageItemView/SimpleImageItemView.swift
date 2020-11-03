//
//  SimpleImageItemView.swift
//  Pokemon
//
//  Created by Alberto Bo on 29/10/2020.
//

import UIKit
import RxSwift

class SimpleImageItemView: UICollectionViewCell, ViewType, CellWithImage {

    override var reuseIdentifier: String? { ItemViewIdentifiers.simpleImage.viewName }

    var imageView: UIImageView { image }

    let image: UIImageView = UIImageView(frame: .zero)

    let disposeBag: DisposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(with viewModel: ItemViewModelType) { }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image =  AppImages.pokemonLogo.image
    }
}

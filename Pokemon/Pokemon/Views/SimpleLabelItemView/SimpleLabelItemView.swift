//
//  SimpleLabelItemView.swift
//  Pokemon
//
//  Created by Alberto Bo on 29/10/2020.
//

import UIKit

class SimpleLabelItemView: UICollectionViewCell, ViewType {

    override var reuseIdentifier: String? { ItemViewIdentifiers.simpleLabel.viewName }

    let label: UILabel = UILabel(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(with viewModel: ItemViewModelType) {
        guard let viewModel = viewModel as? SimpleLabelItemViewModel else { return }
       
        label.text = viewModel.string
        label.apply(style: viewModel.style)
        contentView.layer.borderWidth = viewModel.hasBorder ? 1 : 0
    }
}

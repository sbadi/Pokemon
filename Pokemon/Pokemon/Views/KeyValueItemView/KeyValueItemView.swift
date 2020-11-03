//
//  KeyValueItemView.swift
//  Pokemon
//
//  Created by Alberto Bo on 29/10/2020.
//


import UIKit

class KeyValueItemView: UICollectionViewCell, ViewType {

    override var reuseIdentifier: String? { ItemViewIdentifiers.keyValue.viewName }

    let keyLabel: UILabel = UILabel(frame: .zero)
    let valueLabel: UILabel = UILabel(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(with viewModel: ItemViewModelType) {
        guard let viewModel = viewModel as? KeyValueItemViewModel else { return }

        self.keyLabel.text = viewModel.key
        self.valueLabel.text = viewModel.value
    }
}

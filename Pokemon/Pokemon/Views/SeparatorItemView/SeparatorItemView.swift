//
//  SeparatorItemView.swift
//  Pokemon
//
//  Created by Alberto Bo on 30/10/2020.
//


import UIKit

class SeparatorItemView: UICollectionViewCell, ViewType {

    override var reuseIdentifier: String? { ItemViewIdentifiers.separator.viewName }

    let separator: UIView = UIView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(with viewModel: ItemViewModelType) {
        guard let _ = viewModel as? SeparatorItemViewModel else { return }
    }
}

//
//  LoadMoreItemView.swift
//  Pokemon
//
//  Created by Alberto Bo on 26/10/2020.
//


import UIKit

class LoadMoreItemView: UICollectionViewCell, ViewType {

    override var reuseIdentifier: String? { ItemViewIdentifiers.loadMore.viewName }

    let buttonView: UIView = UIView(frame: .zero)
    let buttonLabel: UILabel = UILabel(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(with viewModel: ItemViewModelType) {
        guard let viewModel = viewModel as? LoadMoreItemViewModel else { return }
        buttonLabel.text = viewModel.buttonTitle.uppercased()
    }

}

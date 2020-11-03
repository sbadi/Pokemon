//
//  ListViewControllerLayout.swift
//  Pokemon
//
//  Created by Alberto Bo on 26/10/2020.
//

import Foundation
import UIKit

extension ListViewController: Layoutable {

    func setStyle() {
        collectionView?.backgroundColor = .clear
        view.backgroundColor = .background
    }

    func setLayout() {

        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        drawCollectionView()
        setupLoaderView()

    }

    private func drawCollectionView() {

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical

        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView = cv

        guard let collectionView = collectionView else { return }

        ItemViewIdentifiers.allCases.forEach {
            collectionView.register($0.viewClass?.class(), forCellWithReuseIdentifier: $0.viewName)
        }

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor), collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor), collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    override func viewDidLayoutSubviews() {
        setStyle()
        super.viewDidLayoutSubviews()
    }
}

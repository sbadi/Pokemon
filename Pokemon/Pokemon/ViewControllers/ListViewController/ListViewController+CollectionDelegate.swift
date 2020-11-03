//
//  ListViewController+CollectionDelegate.swift
//  Pokemon
//
//  Created by Alberto Bo on 26/10/2020.
//

import Foundation
import UIKit

extension ListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let pokemonListVM = self.viewModel as? PokemonListViewModel {
            let item = pokemonListVM.sections.value[indexPath.section].items[indexPath.item]
            if let pokemonItem = (item as? PokemonItemViewModel)?.pokemon {
                if pokemonItem.url == nil {
                    self.showPokemonDetails(for: pokemonItem)
                } else {
                    self.showConnectionError()
                }

            } else if item is LoadMoreItemViewModel {
                pokemonListVM.loadMore()
            }
        }
    }
}

extension ListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.sections.value[section].items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let item =  viewModel.sections.value[indexPath.section].items[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.cellIdentifiers.viewName, for: indexPath)
        (cell as? ViewType)?.bind(with: item)
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.value.count
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        guard let imageCell = cell as? CellWithImage,
              let item = self.viewModel.sections.value[indexPath.section].items[indexPath.item] as? WithImage else { return }

        item.downloadImage { image in
            DispatchQueue.main.async {
                imageCell.imageView.image = image
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let section = viewModel.sections.value[indexPath.section]
        let itemsPerLine: CGFloat = CGFloat(section.itemsPerLine)

        var width: Double = Double(collectionView.bounds.width / itemsPerLine)
        width -= Double(section.edgeInsets.left + section.edgeInsets.right + section.itemSpacing)

        var height: Double = Double(width + width * 0.5)

        if let cellHeight = section.items[indexPath.item].cellHeight {
            height = Double(cellHeight)
        }
        height -= Double(section.edgeInsets.top + section.edgeInsets.bottom) + Double(section.lineSpacing / 2.0)

        if height <= 0 {
            height = 1
        }

        return CGSize(width: width.round(to: 1), height: height.round(to: 1))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        viewModel.sections.value[section].edgeInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        viewModel.sections.value[section].lineSpacing
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        viewModel.sections.value[section].itemSpacing
    }
}
extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

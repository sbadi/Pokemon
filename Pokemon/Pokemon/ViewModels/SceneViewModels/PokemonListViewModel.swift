//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Alberto Bo on 26/10/2020.
//

import Foundation
import RxSwift
import RxCocoa


class PokemonListViewModel: ListViewModelType, WithLoading {

    var isLoading: BehaviorRelay<Int> = .init(value: 0)
    var sections: BehaviorRelay<[Section]> = .init(value: [])
    var disposeBag: DisposeBag  = DisposeBag()
    var reloadDisposeBag = DisposeBag()
    var headerTitle: String { "pokemon_header".localized }
    let pokemonListResponse: BehaviorRelay<PokemonListResponseModel> = .init(value: .empty)

    let repository: PokemonRepository
    let itemViewModelFactory: ItemViewFactory

    init(repository: PokemonRepository,
         itemViewModelFactory: ItemViewFactory) {
        self.repository = repository
        self.itemViewModelFactory = itemViewModelFactory
    }

    func reload() {

        self.reloadDisposeBag = DisposeBag()

        self.repository
            .getPokemonList(with: 0, limit: AppConstants.pokemonPerPage)
            .observeOn(SerialDispatchQueueScheduler(qos: .utility))
            .take(1)
            .map { [weak self] response -> [Section] in
                return self?.buildSections(with: response) ?? []
            }
            .observeOn(MainScheduler.asyncInstance)
            .bindingLoadingStatus(to: self.isLoading)
            .catchErrorJustReturn([])
            .bind(to: self.sections)
            .disposed(by: self.reloadDisposeBag)
    }

    func loadMore() {

        guard let loadMore = self.sections.value.last?.items.last as? LoadMoreItemViewModel else { return }

        sections
            .debounce(.milliseconds(500), scheduler: MainScheduler.asyncInstance)
            .observeOn(SerialDispatchQueueScheduler(qos: .utility))
            .take(1)
            .flatMapLatest { [weak self] sections -> Observable<[Section]> in

                guard let self = self else { return .empty() }
                let items = sections
                    .filter { $0.items.last as? LoadMoreItemViewModel == nil }
                    .flatMap { $0.items }

                return self.repository
                    .getNextPokemons(from: loadMore.currentResponse)
                    .take(1)
                    .observeOn(SerialDispatchQueueScheduler(qos: .utility))
                    .map { [weak self] response -> [Section] in
                        return self?.buildSections(with: response, initialItems: items) ?? []
                    }
                    .bindingLoadingStatus(to: self.isLoading)

            }
            .observeOn(MainScheduler.asyncInstance)
            .bindingLoadingStatus(to: self.isLoading)
            .catchErrorJustReturn([])
            .bind(to: self.sections)
            .disposed(by: self.reloadDisposeBag)
        
    }

    private func buildSections(with response: PokemonListResponseModel, initialItems: [ItemViewModelType] = []) -> [Section] {

        var items: [ItemViewModelType] = initialItems

        let newItems: [ItemViewModelType] = response
            .results
            .map { self.itemViewModelFactory.pokemonList(with: $0) }

        items.append(contentsOf: newItems)

        var itemsSection = [Section(items: items, itemsPerLine: 3, lineSpacing: 6.0, itemSpacing: -3.0, edgeInsets: UIEdgeInsets.init(top: 6.0, left: 6.0, bottom: 6.0, right: 6.0))]

        if response.next != nil {

            itemsSection.append(Section(items: [self.itemViewModelFactory.showMore(with: response)]))
        }

        return itemsSection
    }
}

//
//  PokemonDetailsViewModel.swift
//  Pokemon
//
//  Created by Alberto Bo on 28/10/2020.
//
import Foundation
import RxSwift
import RxCocoa

class PokemonDetailsViewModel: ListViewModelType, WithLoading {

    var isLoading: BehaviorRelay<Int> = .init(value: 0)

    var sections: BehaviorRelay<[Section]> = .init(value: [])
    var disposeBag: DisposeBag  = DisposeBag()
    var reloadDisposeBag = DisposeBag()
    var headerTitle: String { pokemon.name?.sanitized ?? "pokemon_details".localized }
    let pokemonListResponse: BehaviorRelay<PokemonListResponseModel> = .init(value: .empty)

    let repository: PokemonRepository
    let itemViewModelFactory: ItemViewFactory
    let pokemon: PokemonModel

    init(pokemon: PokemonModel,
         repository: PokemonRepository,
         itemViewModelFactory: ItemViewFactory) {
        self.pokemon = pokemon
        self.repository = repository
        self.itemViewModelFactory = itemViewModelFactory
    }

    func reload() {
        self.reloadDisposeBag = DisposeBag()

        let pokemonModel = self.pokemon

        Observable
            .just(pokemonModel)
            .observeOn(SerialDispatchQueueScheduler(qos: .utility))
            .map {
                self.buildSections(with: $0)
            }
            .bindingLoadingStatus(to: self.isLoading)
            .observeOn(MainScheduler.asyncInstance)
            .catchErrorJustReturn([])
            .bind(to: self.sections)
            .disposed(by: self.reloadDisposeBag)
    }


    private func buildSections(with pokemon: PokemonModel) -> [Section] {
        var sections: [Section] = []
        sections.append(contentsOf: self.buildImageSections(with: pokemon))
        sections.append(contentsOf: self.buildInfoSections(with: pokemon))
        sections.append(contentsOf: self.buildTypesSections(with: pokemon))
        sections.append(contentsOf: self.buildAbilitiesSections(with: pokemon))
        sections.append(contentsOf: self.buildStatsSections(with: pokemon))
        sections.append(contentsOf: self.buildMovesSections(with: pokemon))
        return sections
    }

    private func buildStatsSections(with pokemon: PokemonModel) -> [Section] {

        var sections: [Section] = []
        if !(pokemon.stats?.isEmpty ?? true) {

            let title = itemViewModelFactory.simpleLabel(string: "statistics".localized , style: .header, hasBorder: false)

            let items: [Section] = (pokemon
                .stats ?? [])
                .sorted(by: { $0.stat?.name ?? "" > $1.stat?.name ?? "" })
                        .compactMap {

                            guard let name = $0.stat?.name?.sanitized,
                                  let base = $0.base else { return nil }

                            return Section(items: [
                                self.itemViewModelFactory.simpleLabel(string: name, style: .keyLabel, hasBorder: false),
                                self.itemViewModelFactory.simpleLabel(string: "\(base)/100", style: .statLabel, hasBorder: true),
                            ],itemsPerLine: 2, lineSpacing: 3.0, itemSpacing: -3.0, edgeInsets: UIEdgeInsets.init(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0))
                        }

                    sections.append(Section(items: [itemViewModelFactory.separator(), title], lineSpacing: .zero, edgeInsets: UIEdgeInsets.init(top: 12.0, left: 12.0, bottom: .zero, right: 12.0)))

                    sections.append(contentsOf: items)

                }
        return sections
    }
    

    private func buildMovesSections(with pokemon: PokemonModel) -> [Section] {

        var sections: [Section] = []

        if !(pokemon.moves?.isEmpty ?? true){

            let items = pokemon.moves?
                .compactMap { $0.move?.name?.sanitized }
                .sorted()
                .compactMap {
                    itemViewModelFactory.simpleLabel(string: $0, style: .propertyLabel, hasBorder: true)
                } ?? []

            if !items.isEmpty {

                let title = itemViewModelFactory.simpleLabel(string: "moves".localized, style: .header, hasBorder: false)

                sections.append(Section(items: [itemViewModelFactory.separator(), title], lineSpacing: .zero, edgeInsets: UIEdgeInsets.init(top: 12.0, left: 12.0, bottom: .zero, right: 12.0)))
                sections.append(Section(items: items,itemsPerLine: 3, lineSpacing: 3.0, itemSpacing: -3.0, edgeInsets: UIEdgeInsets.init(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0)))
            }
        }

        return sections
    }

    private func buildAbilitiesSections(with pokemon: PokemonModel) -> [Section] {

        var sections: [Section] = []

        if !(pokemon.abilities?.isEmpty ?? false) {

            let items = pokemon.abilities?
                .compactMap { $0.ability?.name?.sanitized }
                .sorted()
                .compactMap {
                    itemViewModelFactory.simpleLabel(string: $0, style: .propertyLabel, hasBorder: true)
                } ?? []

            if !items.isEmpty  {

                let title = itemViewModelFactory.simpleLabel(string: "abilities".localized, style: .header, hasBorder: false)

                sections.append(Section(items: [itemViewModelFactory.separator(), title], edgeInsets: UIEdgeInsets.init(top: 12.0, left: 12.0, bottom: .zero, right: 12.0)))
                sections.append(Section(items: items,itemsPerLine: 3, lineSpacing: 3.0, itemSpacing: -3.0, edgeInsets: UIEdgeInsets.init(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0)))
            }

        }

        return sections

    }

    private func buildTypesSections(with pokemon: PokemonModel) -> [Section] {

        var sections: [Section] = []
        if !(pokemon.types?.isEmpty ?? true) {

            let items = pokemon.types?
                .compactMap { $0.type?.name?.sanitized }
                .sorted()
                .compactMap {
                    itemViewModelFactory.simpleLabel(string: $0, style: .propertyLabel, hasBorder: true)
                } ?? []

            if !items.isEmpty {
                let title = itemViewModelFactory.simpleLabel(string: "types".localized, style: .header, hasBorder: false)

                sections.append(Section(items: [itemViewModelFactory.separator(), title], edgeInsets: UIEdgeInsets.init(top: 12.0, left: 12.0, bottom: .zero, right: 12.0)))
                sections.append(Section(items: items,itemsPerLine: 3, lineSpacing: 3.0, itemSpacing: -3.0, edgeInsets: UIEdgeInsets.init(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0)))
            }

        }

        return sections
    }

    private func buildInfoSections(with pokemon: PokemonModel) -> [Section] {

        var sections: [Section] = []

        if let name = pokemon.name?.sanitized {
            sections.append(Section(items: [itemViewModelFactory.keyValue(key: "name".localized, value: name)]))
        }

        if let size = pokemon.size {
            sections.append(Section(items: [itemViewModelFactory.keyValue(key: "size".localized, value: size)]))
        }
        return sections
    }

    private func buildImageSections(with pokemon: PokemonModel) -> [Section] {
        var sections: [Section] = []

        if let image = pokemon.images?.icon, let id = pokemon.pokemonId {

            sections.append(Section(items: [itemViewModelFactory.simpleImage(url: image, imageId: NSNumber(value: id))]))
            sections.append(Section(items: [itemViewModelFactory.separator()], edgeInsets: UIEdgeInsets(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0)))
        }
        return sections
    }
}

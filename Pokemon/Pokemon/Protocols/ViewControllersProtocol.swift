//
//  SceneViewModelType.swift
//  Pokemon
//
//  Created by Alberto Bo on 26/10/2020.
//
import RxCocoa
import RxSwift

protocol SceneViewModelType {
    var headerTitle: String { get }
    var disposeBag: DisposeBag { get set }
}

protocol ListViewModelType: SceneViewModelType {
    func reload()
    var reloadDisposeBag: DisposeBag { get set }
    var sections: BehaviorRelay<[Section]> {get set}
}

protocol ViewControllerType {
    var disposeBag: DisposeBag { get set }
    func showPokemonList()
    func showPokemonDetails(for pokemon: PokemonModel)
}

extension ViewControllerType where Self: UIViewController {

    func showPokemonDetails(for pokemon: PokemonModel) {
        if #available(iOS 13.0, *) {
            (self.view.window?.windowScene?.delegate as? Router)?.showPokemonDetails(for: pokemon, from: self)
        } else {
            (UIApplication.shared.delegate as? Router)?.showPokemonDetails(for: pokemon, from: self)
        }
    }

    func showPokemonList() {
        if #available(iOS 13.0, *) {
            (self.view.window?.windowScene?.delegate as? Router)?.startApplication()
        } else {
            (UIApplication.shared.delegate as? Router)?
                .startApplication()
        }
    }
}

protocol WithLoading {
    var isLoading: BehaviorRelay<Int> { get set }
}

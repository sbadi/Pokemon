//
//  LoaderUtilities.swift
//  Pokemon
//
//  Created by Alberto Bo on 28/10/2020.
//

import UIKit
import RxSwift
import RxCocoa


protocol Loadable {
    var progressView: LoaderItemView { get set }
    func setupLoaderView()
}
extension Loadable where Self : UIViewController {

    func setupLoaderView() {

        progressView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressView)

        let constraints = [
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressView.leftAnchor.constraint(equalTo: view.leftAnchor), progressView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor), progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
        progressView.bringSubviewToFront(view)
        progressView.isAnimating = false
    }
}


extension Observable {

    func bindingLoadingStatus(to handler: BehaviorRelay<Int>) -> Observable<Element> {
        return self.do(onSubscribed: { [weak handler] in
            guard let handler = handler else { return }
            handler.accept(handler.value + 1)
        },
        onDispose: { [weak handler] in
            guard let handler = handler else { return }
            handler.accept(max(handler.value - 1, 0))
        })
    }
}

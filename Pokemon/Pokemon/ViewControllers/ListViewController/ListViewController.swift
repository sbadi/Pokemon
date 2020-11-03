//
//  ListViewController.swift
//  Pokemon
//
//  Created by Alberto Bo on 26/10/2020.
//

import UIKit
import RxSwift

class ListViewController: UIViewController, ViewControllerType, Loadable {

    var progressView: LoaderItemView = LoaderItemView()
    var collectionView: UICollectionView?

    var viewModel: ListViewModelType
    var disposeBag = DisposeBag()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(nibName nibNameOrNil: String? = nil,
         bundle nibBundleOrNil: Bundle? = nil,
         viewModel: ListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        title = viewModel.headerTitle
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()

        configureCollectionView()
        setupLoaderView()
        
        (viewModel as? WithLoading)?.isLoading
            .asDriver()
            .drive(progressView.rx.isAnimating)
            .disposed(by: self.disposeBag)
    }

    private func configureCollectionView() {

        viewModel
            .sections
            .asObservable()
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [weak self] sections in
                self?.collectionView?.reloadData()
            })
            .disposed(by: self.disposeBag)

        collectionView?.delegate = self
        collectionView?.dataSource = self
        viewModel.reload()
    }

    func showConnectionError() {
        let message = "connection_error".localized
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "close".localized, style: .cancel) { (action:UIAlertAction) in }
        alert.addAction(close)
        self.present(alert, animated: true, completion: nil)
    }
   
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(
            alongsideTransition: { [weak self] _ in self?.collectionView?.collectionViewLayout.invalidateLayout() },
            completion: { _ in }
        )
    }
}

//
//  BaseViewController.swift
//  FinallyApp
//
//  Created by Ernazar on 27/8/23.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.register(ImageCollectionViewCell.self,forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewModel: HomeViewModelProtocol! {
        didSet {
            viewModel?.fetchData(completion: { [weak self] in
                DispatchQueue.main.async {
                    self?.imageCollectionView.reloadData()
                }
            })
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        imageCollectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    func setup() {
        navSetup()
        setupAppearance()
    }
    
    func navSetup() {
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupAppearance() {
        view.backgroundColor = .white
        
        view.addSubview(imageCollectionView)
        imageCollectionView.frame = view.bounds
    }

}

//MARK: - ImageCollectionViewCellDelegate
extension BaseViewController: ImageCollectionViewCellDelegate {
    func favoriteButtonTapped(state: Bool, id: String) {
        viewModel.changeStateIsFavorite(state: state, id: id) { [weak self] result in
            if result { self?.imageCollectionView.reloadData() }
        }
    }
}

//MARK: - UICollectionViewDataSource
extension BaseViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
        guard let count = viewModel?.getCountData else { return 0 }
        return count
    }

    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ImageCollectionViewCell.identifier,
            for: indexPath
        ) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        cell.delegate = self
        let model = viewModel.getDataCell(at: indexPath)
        cell.configure(model: model)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension BaseViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.getViewModelForSelectedRow(at: indexPath) {[weak self] viewModel in
            DispatchQueue.main.async {
                let vc = DetailViewController()
                vc.viewModel = viewModel
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension BaseViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: view.bounds.width / 2 - 30, height: 200 / view.bounds.height * 852)
    }
    
    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        15
    }
    
    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        10
    }
}


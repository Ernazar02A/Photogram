//
//  FavoriteViewController.swift
//  FinallyApp
//
//  Created by Ernazar on 27/8/23.
//

import UIKit

class FavoriteViewController: BaseViewController {
    
    var viewModel: FavoriteViewModel! {
        didSet {
            viewModel.fetchData { [weak self] in
                DispatchQueue.main.async {
                    self?.imageCollectionView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.fetchData(completion: { [weak self] in
            DispatchQueue.main.async {
                self?.imageCollectionView.reloadData()
            }
        })
    }
    
    override func setup() {
        super.setup()
        imageCollectionView.dataSource = self
    }
    
    init(viewModel: FavoriteViewModel!) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setupAppearance() {
        super.setupAppearance()
        title = "Favorite"
    }
}

//MARK: - ImageCollectionViewCellDelegate
extension FavoriteViewController: ImageCollectionViewCellDelegate {
    func favoriteButtonTapped(state: Bool, id: String) {
        viewModel.changeStateIsFavorite(state: state, id: id) { [weak self] result in
            if result { self?.imageCollectionView.reloadData() }
        }
    }
}

//MARK: - UICollectionViewDataSource
extension FavoriteViewController: UICollectionViewDataSource {
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

//
//  HomeViewController.swift
//  FinallyApp
//
//  Created by Ernazar on 24/8/23.
//

import UIKit

class HomeViewController: BaseViewController {
    private lazy var searchController: UISearchController = {
        let view = UISearchController()
        view.searchResultsUpdater = self
        view.searchBar.searchBarStyle = .minimal
        return view
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        return view
    }()
    
    var viewModel: HomeViewModel! {
        didSet {
            viewModel.fetchData { [weak self] in
                DispatchQueue.main.async {
                    self?.imageCollectionView.reloadData()
                }
            }
        }
    }
    
    init(viewModel: HomeViewModel!) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        super.setup()
        viewModel = HomeViewModel()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        imageCollectionView.refreshControl = refreshControl
        imageCollectionView.dataSource = self
    }
    
    override func setupAppearance() {
        super.setupAppearance()
        title = "HOME"
    }
    
    override func setupNavigation() {
        super.setupNavigation()
        navigationItem.searchController = searchController
    }
    @objc func refreshAction(_ sender: UIRefreshControl) {
        viewModel?.fetchData {
            DispatchQueue.main.async { [weak self] in
                self?.imageCollectionView.reloadData()
                sender.endRefreshing()
            }
        }
    }
}

//MARK: - ImageCollectionViewCellDelegate
extension HomeViewController: ImageCollectionViewCellDelegate {
    func favoriteButtonTapped(state: Bool, id: String) {
        viewModel.changeStateIsFavorite(state: state, id: id) { [weak self] result in
            if result { self?.imageCollectionView.reloadData() }
        }
    }
}

//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
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

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel?.search(query: searchController.searchBar.text, completion: {
            DispatchQueue.main.async {[weak self] in
                self?.imageCollectionView.reloadData()
            }
        })
    }
}

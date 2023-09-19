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
    
    override func setup() {
        super.setup()
        viewModel = HomeViewModel()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        imageCollectionView.refreshControl = refreshControl
    }
    
    override func setupAppearance() {
        super.setupAppearance()
        title = "HOME"
    }
    
    override func navSetup() {
        super.navSetup()
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

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel?.search(query: searchController.searchBar.text, completion: {
            DispatchQueue.main.async {[weak self] in
                self?.imageCollectionView.reloadData()
            }
        })
    }
}

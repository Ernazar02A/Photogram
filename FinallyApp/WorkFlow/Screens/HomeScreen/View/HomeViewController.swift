//
//  HomeViewController.swift
//  FinallyApp
//
//  Created by Ernazar on 24/8/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var searchController: UISearchController = {
        let view = UISearchController()
        view.searchResultsUpdater = self
        view.searchBar.searchBarStyle = .minimal
        return view
    }()
    private lazy var imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(
            width: UIScreen.main.bounds.width / 2 - 30, height: 200 / UIScreen.main.bounds.height * 812)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.register(ImageCollectionViewCell.self,forCellWithReuseIdentifier: ImageCollectionViewCell.cellId)
        view.refreshControl = refreshControl
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        return view
    }()
    
    var viewModel: HomeViewModelProtocol? {
        didSet {
            viewModel?.fetchData(completion: { [weak self] in
                DispatchQueue.main.async {
                    self?.imageCollectionView.reloadData()
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }
    
    private func setup() {
        viewModel = HomeViewModel()
        setupView()
        setupSubview()
        navSetup()
    }
    
    private func navSetup() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupView() {
        title = "HOME"
        view.backgroundColor = .white
    }
    
    private func setupSubview() {
        view.addSubview(imageCollectionView)
        imageCollectionView.frame = view.bounds
    }
    
    @objc func refreshAction(_ sender: UIRefreshControl) {
        print("refresh")
        viewModel?.fetchData {
            DispatchQueue.main.async { [weak self] in
                self?.imageCollectionView.reloadData()
                sender.endRefreshing()
            }
        }
    }
}

//MARK: - UISearchResultsUpdating
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
//        viewModel?.search(query: searchController.searchBar.text, completion: {
//            DispatchQueue.main.async {[weak self] in
//                self?.imageCollectionView.reloadData()
//            }
//        })
    }
}

//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
        guard let count = viewModel?.getCountData() else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ImageCollectionViewCell.cellId,
            for: indexPath
        ) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let model = viewModel?.getData(at: indexPath) else {return UICollectionViewCell()}
        cell.setupData(model: model.urls["thumb"]!)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        let viewModel = viewModel?.getViewModelForSelectedRow(at: indexPath)
        vc.viewModel = viewModel
        navigationController?.pushViewController(vc, animated: true)
    }
}

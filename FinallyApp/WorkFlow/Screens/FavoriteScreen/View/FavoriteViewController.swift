//
//  FavoriteViewController.swift
//  FinallyApp
//
//  Created by Ernazar on 27/8/23.
//

import UIKit

class FavoriteViewController: UIViewController {
    private lazy var imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.register(ImageCollectionViewCell.self,forCellWithReuseIdentifier: ImageCollectionViewCell.cellId)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var viewModel: FavoriteViewModelProtocol! {
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
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.fetchData(completion: { [weak self] in
            DispatchQueue.main.async {
                self?.imageCollectionView.reloadData()
            }
        })
    }
    
//    convenience init(viewModel: HomeViewModelProtocol) {
//        self.init(nibName:nil, bundle:nil)
//        self.viewModel = viewModel
//    }
    
    private func setup() {
        viewModel = FavoriteViewModel()
        setupAppearance()
        navSetup()
    }
    
    private func navSetup() {
        navigationItem.hidesSearchBarWhenScrolling = false
        title = "Favorite"
    }
    
    private func setupAppearance() {
        view.backgroundColor = .white
        
        view.addSubview(imageCollectionView)
        imageCollectionView.frame = view.bounds
    }
}

//MARK: - UICollectionViewDataSource
extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
        guard let count = viewModel?.getCountData() else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ImageCollectionViewCell.cellId, for: indexPath
        ) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        let viewModel = viewModel.getViewModelForCell(at: indexPath)
        cell.viewModel = viewModel
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension FavoriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.getViewModelForSelectedRow(at: indexPath) { [weak self] viewModel in
            DispatchQueue.main.async {
                let vc = DetailViewController()
                vc.viewModel = viewModel
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.bounds.width / 2 - 30, height: 200 / view.bounds.height * 852)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets { UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { 15 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { 10 }
}

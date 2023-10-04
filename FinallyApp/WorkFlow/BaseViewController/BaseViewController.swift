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
        view.register(ImageCollectionViewCell.self,forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewWillAppear(_ animated: Bool) {
        imageCollectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    func setup() {
        setupNavigation()
        setupAppearance()
    }
    
    func setupNavigation() {
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupAppearance() {
        view.backgroundColor = .white
        
        view.addSubview(imageCollectionView)
        imageCollectionView.frame = view.bounds
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension BaseViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let size = Constants.SizesSpacingImageColletionViewLayout.self
        let itemcount = size.countItem
        let inset = size.EdgeInsetsSpacings.left + size.EdgeInsetsSpacings.right
        let freeItemsSpace = size.itemSpacing
        let width = (Int(collectionView.frame.size.width - (inset + freeItemsSpace))) / itemcount
        return CGSize(width: CGFloat(width), height: 200 * view.bounds.height / 852)
    }
    
    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 0,
                     left: Constants.SizesSpacingImageColletionViewLayout.EdgeInsetsSpacings.left,
                     bottom: 0,
                     right: Constants.SizesSpacingImageColletionViewLayout.EdgeInsetsSpacings.right)
    }
    
    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constants.SizesSpacingImageColletionViewLayout.lineSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constants.SizesSpacingImageColletionViewLayout.itemSpacing
    }
}


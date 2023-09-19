//
//  FavoriteViewController.swift
//  FinallyApp
//
//  Created by Ernazar on 27/8/23.
//

import UIKit

class FavoriteViewController: BaseViewController {
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.fetchData(completion: { [weak self] in
            DispatchQueue.main.async {
                self?.imageCollectionView.reloadData()
            }
        })
    }
    
    override func setup() {
        super.setup()
        viewModel = FavoriteViewModel()
    }
    
    override func setupAppearance() {
        super.setupAppearance()
        title = "Favorite"
    }
}

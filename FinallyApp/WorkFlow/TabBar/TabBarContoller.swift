//
//  TabBarContoller.swift
//  FinallyApp
//
//  Created by Ernazar on 27/8/23.
//

import UIKit

class TabBarContoller: UITabBarController {
    
    override func viewDidLoad() {
        setupTabBar()
    }
    
    private func setupTabBar() {
        
        let homeViewController = UINavigationController(rootViewController: createViewController(
            viewContoller: HomeViewController(viewModel: HomeViewModel()),
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill"), title: "Home")
        )
        let FavoriteViewController = UINavigationController(rootViewController: createViewController(
            viewContoller: FavoriteViewController(viewModel: FavoriteViewModel()),
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill"), title: "Favorite")
        )
        
        tabBar.tintColor  = .label
        
        setViewControllers([homeViewController, FavoriteViewController], animated: true)
    }
    
    private func createViewController(viewContoller: UIViewController, image: UIImage?, selectedImage: UIImage?, title: String) -> UIViewController {
        viewContoller.tabBarItem.image = image
        viewContoller.tabBarItem.selectedImage = selectedImage
        viewContoller.title = title
        return viewContoller
    }
}

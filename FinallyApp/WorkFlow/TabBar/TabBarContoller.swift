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
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        let FavoriteViewController = UINavigationController(rootViewController: FavoriteViewController())
        
        homeViewController.tabBarItem.image = UIImage(systemName: "house")
        FavoriteViewController.tabBarItem.image = UIImage(systemName: "heart")
 
        homeViewController.title = "home"
        FavoriteViewController.title = "Favorite"
        
        
        tabBar.tintColor  = .label
        
        setViewControllers([homeViewController, FavoriteViewController], animated: true)
    }
}

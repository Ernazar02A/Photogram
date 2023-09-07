//
//  BaseViewController.swift
//  FinallyApp
//
//  Created by Ernazar on 27/8/23.
//

import UIKit

class BaseViewController<T: UIView>: UIViewController {
    
    override func loadView() {
        view = T()
    }
    
    var customView: T {
        view as! T
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

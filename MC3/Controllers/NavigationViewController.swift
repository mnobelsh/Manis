//
//  NavigationViewController.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 10/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit
import ChameleonFramework

class NavigationViewController: UINavigationController {
    
    static let shared = NavigationViewController(rootViewController: ProfileViewController ())
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        navigationBar.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

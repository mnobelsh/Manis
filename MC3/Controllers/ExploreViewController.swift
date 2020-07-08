//
//  HomeViewController.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 07/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import SwiftUI
import UIKit
import SkeletonView
import ChameleonFramework

class ExploreViewController: UIViewController {

    // MARK: - Properties
    let headerView = ExploreHeaderContainer()
    let headerViewInitialHeight: CGFloat = 265
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavbarTransparent()
        
        view.backgroundColor = .systemBackground
        self.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "globe"), selectedImage: UIImage(systemName: "globe"))

        self.view.addSubview(headerView)
        headerView.user = "Muhammad Terapi"

        headerView.frame = CGRect(x: 0, y: -headerViewInitialHeight, width: self.view.frame.width, height: headerViewInitialHeight)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.45, animations: {
            self.headerView.frame.origin.y += self.headerViewInitialHeight
        }) { (_) in
            self.setStatusBarStyle(UIStatusBarStyleContrast)
        }
    }

    
}


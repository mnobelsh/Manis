//
//  MerchantViewController.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 21/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

class MerchantViewController: UIViewController {
    
    var merchant: Merchant? {
        didSet {
            merchantNameLabel.text = merchant?.name
            addressLabel.text = merchant?.address
        }
    }
    
     private var merchantNameLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Merchant Name", fontSize: 20, textColor: .black)
        return label
    }()
     private var addressLabel: UILabel = {
        let label = UILabel()
        label.configureTextLabel(title: "Merchant Address", fontSize: 16, textColor: .darkGray)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.view.backgroundColor = .systemBackground
        configureNavbar()
        
        self.view.addSubview(merchantNameLabel) {
            self.merchantNameLabel.setSize(width: 200, height: 35)
            self.merchantNameLabel.setCenterXYAnchor(in: self.view)
        }
        
        self.view.addSubview(addressLabel) {
            self.addressLabel.setAnchor(top: self.merchantNameLabel.bottomAnchor, paddingTop: 15)
            self.addressLabel.setSize(width: 200, height: 50)
            self.addressLabel.setCenterXAnchor(in: self.view)
        }
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let vc = self.navigationController?.viewControllers.first as? MainViewController else {return}
        vc.hideNavbar()
        guard let listVC = navigationController?.viewControllers.last as? MerchantListViewController else {return}
        listVC.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Helpers
    func configureNavbar() {
        self.navigationController?.navigationBar.isHidden = false
        setTransparentNavbar()
    }
    
}

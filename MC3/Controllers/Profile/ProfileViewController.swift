//
//  ProfileViewController.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 21/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var data: [String:Any]? = nil {
        didSet {
            if let data = data {
                guard let email = data["email"] as? String else {return}
                guard let name = data["name"] as? String else {return}
                nameLabel.text = name
                emailLabel.text = email
                configureUI()
            }
        }
    }
    private var nameLabel = UILabel()
    private var emailLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }
    
    func configureUI() {
        self.view.addSubview(nameLabel)
        nameLabel.font = UIFont.systemFont(ofSize: 24)
        nameLabel.textColor = .white
        nameLabel.setCenterXYAnchor(in: self.view)
        
        self.view.addSubview(emailLabel)
        emailLabel.font = UIFont.systemFont(ofSize: 24)
        emailLabel.textColor = .white
        emailLabel.setAnchor(top: nameLabel.bottomAnchor, paddingTop: 30)
        emailLabel.setCenterXAnchor(in: self.view)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

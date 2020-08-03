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
                guard let name = data["name"] as? String else {return}
                nameLabel.text = name
                configureUI()
            }
        }
    }
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.configureCustomLabel(title: "JohnDoe", fontType: "Heavy", fontSize: 18, textColor: .black)
        return label
    }()
    
    private lazy var favButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "yourFavoritesButton"), for: .normal)
        button.addTarget(self, action: #selector(favButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func favButtonTapped(_ button: UIButton){
        print("Favorite Button Tapped")
    }
    
    private lazy var reviewsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "yourReviewsButton"), for: .normal)
        button.addTarget(self, action: #selector(reviewsButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func reviewsButtonTapped(_ button: UIButton){
        print("Review Button Tapped")
    }
    
    private lazy var topButtonStacks: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [favButton,reviewsButton])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 4
        
        return stack
    }()
    
    private lazy var favLabel: UILabel = {
        let label = UILabel()
        label.configureCustomLabel(title: "Your Favorites", fontType: "Medium", fontSize: 16, textColor: .black)
        return label
    }()
    
    private lazy var reviewLabel: UILabel = {
        let label = UILabel()
        label.configureCustomLabel(title: "Your Reviews", fontType: "Medium", fontSize: 16, textColor: .black)
        return label
    }()
    
//    private lazy var topButtonLabelStacks: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [favLabel,reviewLabel])
//        stack.axis = .horizontal
//        stack.alignment = .center
//        stack.distribution = .fillEqually
//        stack.spacing = 10
//
//        return stack
//    }()
    
    private lazy var leftSideStacks: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [favButton,favLabel,editProfileButton,editLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 5
        return stack
    }()
    
    private lazy var editProfileButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "editProfileButton"), for: .normal)
        button.addTarget(self, action: #selector(editProfileButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func editProfileButtonTapped(_ button: UIButton){
        print("Edit Button Tapped")
    }
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "logoutButton"), for: .normal)
        button.addTarget(self, action: #selector(logoutButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func logoutButtonTapped(_ button: UIButton){
        print("Logout Button Tapped")
    }
    
//    private lazy var bottomButtonStacks: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [editProfileButton,logoutButton])
//        stack.axis = .horizontal
//        stack.alignment = .fill
//        stack.distribution = .fillEqually
//        stack.spacing = 3
//
//        return stack
//    }()
    
    private lazy var editLabel: UILabel = {
        let label = UILabel()
        label.configureCustomLabel(title: "Edit Profile", fontType: "Medium", fontSize: 16, textColor: .black)
        return label
    }()
    
    private lazy var logoutLabel: UILabel = {
        let label = UILabel()
        label.configureCustomLabel(title: "Logout", fontType: "Medium", fontSize: 16, textColor: .black)
        return label
    }()
    
//    private lazy var bottomButtonLabelStacks: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [editLabel,logoutLabel])
//        stack.axis = .horizontal
//        stack.alignment = .fill
//        stack.distribution = .fillEqually
//        stack.spacing = 3
//
//        return stack
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(nameLabel){
            self.nameLabel.setCenterXAnchor(in: self.view)
            self.nameLabel.setAnchor(top: self.view.topAnchor, paddingTop: 120, paddingRight: 15, paddingBottom: 15, paddingLeft: 15)
        }
        
        view.addSubview(leftSideStacks){
            self.leftSideStacks.setAnchor(top: self.nameLabel.bottomAnchor, left: self.view.leftAnchor, paddingTop: 200, paddingRight: 15, paddingBottom: 15, paddingLeft: 15)
        }
        
//        view.addSubview(topButtonStacks){
//            self.topButtonStacks.setAnchor(top: self.nameLabel.bottomAnchor,right: self.view.rightAnchor, left: self.view.leftAnchor, paddingTop: 200, paddingRight: 15, paddingBottom: 15, paddingLeft: 15)
//        }
        
        
        
//        view.addSubview(topButtonLabelStacks){
//            self.topButtonLabelStacks.setAnchor(top: self.topButtonStacks.bottomAnchor,right: self.view.rightAnchor, left: self.view.leftAnchor, paddingTop: 8, paddingRight: 15, paddingBottom: 15, paddingLeft: 45)
//        }
        
//        view.addSubview(bottomButtonStacks){
//            self.bottomButtonStacks.setAnchor(top: self.topButtonLabelStacks.bottomAnchor,right: self.view.rightAnchor, left: self.view.leftAnchor, paddingTop: 50, paddingRight: 15, paddingBottom: 15, paddingLeft: 15)
//        }
//
//        view.addSubview(bottomButtonLabelStacks){
//            self.bottomButtonLabelStacks.setAnchor(top: self.bottomButtonStacks.bottomAnchor,right: self.view.rightAnchor, left: self.view.leftAnchor, paddingTop: 8, paddingRight: 15, paddingBottom: 15, paddingLeft: 15)
//        }
    }
    
    func configureUI() {
        self.view.addSubview(nameLabel)
        
        
    }

}

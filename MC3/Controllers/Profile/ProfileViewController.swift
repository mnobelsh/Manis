//
//  ProfileViewController.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 21/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    var user: User? {
        didSet {
            guard let user = user else { return }
            FirebaseService.shared.downloadUserProfileImage(forUserID: user.id) { (image, error) in
                if let err = error {
                    print(err.localizedDescription)
                } else {
                    self.profileImage.image = image                }
            }
            self.nameLabel.text = user.name
        }
    }
    
    private lazy var profileImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "profilePictureBig")
        img.setSize(width: 120, height: 120)
        
        return img
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.configureCustomLabel(title: "JohnDoe", fontType: "Heavy", fontSize: 18, textColor: .black)
        return label
    }()
    
    private lazy var favButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "yourFavoritesButton"), for: .normal)
        button.addTarget(self, action: #selector(favButtonTapped(_:)), for: .touchUpInside)
        button.setSize(width: 100, height: 100)
        return button
    }()
    
    private lazy var reviewsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "yourReviewsButton"), for: .normal)
        button.addTarget(self, action: #selector(reviewsButtonTapped(_:)), for: .touchUpInside)
        button.setSize(width: 100, height: 100)

        return button
    }()
    
    private lazy var leftButtonStacks: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [favButton,favLabel,editProfileButton,editLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 10
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
    
    private lazy var editProfileButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "editProfileButton"), for: .normal)
        button.addTarget(self, action: #selector(editProfileButtonTapped(_:)), for: .touchUpInside)
        button.setSize(width: 100, height: 100)
        return button
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "logoutButton"), for: .normal)
        button.addTarget(self, action: #selector(logoutButtonTapped(_:)), for: .touchUpInside)
        button.setSize(width: 100, height: 100)
        return button
    }()
    
    private lazy var rightButtonStacks: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [reviewsButton,reviewLabel,logoutButton,logoutLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 10
        return stack
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setTransparentNavbar()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .black
        self.title = "Profile"
        
        view.addSubview(profileImage){
            self.profileImage.setCenterXAnchor(in: self.view)
            self.profileImage.setAnchor(top: self.view.topAnchor, paddingTop: self.view.frame.height/7, paddingRight: 8, paddingBottom: 8, paddingLeft: 8)
        }
        
        view.addSubview(nameLabel){
            self.nameLabel.setCenterXAnchor(in: self.view)
            self.nameLabel.setAnchor(top: self.profileImage.bottomAnchor, paddingTop: 8, paddingRight: 15, paddingBottom: 15, paddingLeft: 15)
        }
        
        view.addSubview(leftButtonStacks){
            self.leftButtonStacks.setAnchor(top: self.nameLabel.bottomAnchor, left: self.view.leftAnchor, paddingTop: self.view.frame.height/10, paddingLeft: 55)
        }
        
        view.addSubview(rightButtonStacks){
            self.rightButtonStacks.setAnchor(top: self.nameLabel.bottomAnchor, right: self.view.rightAnchor, paddingTop: self.view.frame.height/10, paddingRight: 55)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let vc = navigationController?.viewControllers.first as? MainViewController else {return}
    }
    
    
    func configureUI() {
        self.view.addSubview(nameLabel)
        nameLabel.font = UIFont.systemFont(ofSize: 24)
        nameLabel.textColor = .white
        nameLabel.setCenterXYAnchor(in: self.view)
    }

    
    @objc func favButtonTapped(_ button: UIButton){
        let merchantListVC = MerchantListViewController()
        merchantListVC.merchantListType = .favorites
        self.navigationController?.pushViewController(merchantListVC, animated: true)
    }
    
    @objc func reviewsButtonTapped(_ button: UIButton){
        print("Review Button Tapped")
        let allReviewVC = AllReviewVC()
        allReviewVC.addButton.isHidden = true
        allReviewVC.userID = user!.id
        allReviewVC.allReviewsFor = .user
        self.navigationController?.pushViewController(allReviewVC, animated: true)
    }
    
    @objc func editProfileButtonTapped(_ button: UIButton){
        print("Edit Button Tapped")
        let editVC = EditProfileViewController()
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    @objc func logoutButtonTapped(_ button: UIButton){
        FirebaseService.shared.signOut {
            guard let vc = self.navigationController?.viewControllers.first as? MainViewController else {return}
            vc.fetchUser()
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}

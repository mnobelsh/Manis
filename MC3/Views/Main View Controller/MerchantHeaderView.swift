//
//  MerchantHeaderView.swift
//  MC3
//
//  Created by Muhammad Thirafi on 29/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

protocol MerchantHeaderViewDelegate {
    func favDidTapped(_ button: UIButton)
//    func backButtView()
}

class MerchantHeaderView: UIView {
    
    var delegate: MerchantHeaderViewDelegate?
    var merchant: Merchant? {
        didSet {
            guard let merchant = merchant else {return}
            nameMerchant.text = merchant.name
            phoneNumber = merchant.phoneNumber
            
            FirebaseService.shared.fetchMerchantRating(forMerchantID: merchant.id) { (rating,reviewersCount,error) in
                if let rating = rating, let reviewersCount = reviewersCount {
                    self.ratingLabel.text = String(rating)
                    self.reviewerLabel.text = "(\(reviewersCount) Review)"
                }
            }
        }
    }
    var user: User? 
    static let height: CGFloat = 261
    private var phoneNumber: String = "+62218641727"

    private lazy var favButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "notfav"), for: .normal)
        button.addTarget(self, action: #selector(favisTapped), for: .touchUpInside)
        button.isHidden = Bool(Auth.auth().currentUser == nil)
        return button
    }()
    
    private var nameMerchant: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Bang bang tut", fontSize: 24, textColor: .white)
        return label
    }()
    
    private lazy var callButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "callButton"), for: .normal)
//        button.setSize(width: 100, height: 48)
        button.addTarget(self, action: #selector(callTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var directionButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "locationButton"), for: .normal)
//        button.setSize(width: 143, height: 48)
        return button
    }()
    
    private var ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.backgroundColor = .clear
        ratingLabel.configureHeadingLabel(title: "0.0", fontSize: 14, textColor: .black)
        ratingLabel.textAlignment = .left
        return ratingLabel
    }()
    private lazy var ratingView: UIView = {
        let view = UIView()
        view.configureRatingView(ratingLabel: ratingLabel)
        return view
    }()
    
    private lazy var reviewerLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "(0 Review)", fontSize: 12, textColor: .white)
        return label
    }()
    
    //MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(favButton) {
            self.favButton.setAnchor(top: self.safeAreaLayoutGuide.topAnchor, right: self.rightAnchor, paddingTop: 8, paddingRight: 8)
        }
        
        self.addSubview(nameMerchant) {
            self.nameMerchant.setAnchor(top: self.favButton.bottomAnchor,left: self.safeAreaLayoutGuide.leftAnchor, paddingTop: 18, paddingLeft: 8)
        }
        
        self.addSubview(callButton) {
            self.callButton.setAnchor(top: self.nameMerchant.bottomAnchor, left: self.leftAnchor, paddingTop: 8, paddingLeft: 8)
        }
        
        self.addSubview(directionButton) {
            self.directionButton.setAnchor(top: self.nameMerchant.bottomAnchor, left: self.callButton.rightAnchor, paddingTop: 8)
        }
        
        self.addSubview(ratingView){
            self.ratingView.setAnchor(top: self.nameMerchant.bottomAnchor, left: self.directionButton.rightAnchor,paddingTop: 8,paddingLeft: 8)
        }
        
        self.addSubview(reviewerLabel){
            self.reviewerLabel.setAnchor( top: self.ratingView.bottomAnchor, left: self.directionButton.rightAnchor, paddingTop: 0, paddingLeft: 8)
        }
        
        self.backgroundColor = .gray
        
//        let width = self.frame.width
//        let height = self.frame.height
//
//        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
//        imageViewBackground.image = UIImage(named: "default header")
//        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
//
//        self.addSubview(imageViewBackground)
//        self.sendSubviewToBack(imageViewBackground)
        
        self.configureRoundedCorners(corners: [.bottomLeft,.bottomRight], radius: 25)
        self.configureShadow(shadowColor: .lightGray, radius: 6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - FUNCTIONS
    
    @objc private func favisTapped(_ button: UIButton){
        button.isSelected = !button.isSelected
        delegate?.favDidTapped(button)
    }
    
    @objc private func callTapped(_ button: UIButton){
        if let url = URL(string: "tel://\(self.phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    func configureComponents(merchant: Merchant, userFavs: [String]?){
        self.merchant = merchant
        
        if let userFavs = userFavs, userFavs.contains(merchant.id) {
            self.favButton.setImage(#imageLiteral(resourceName: "addToFavoriteButton"), for: .normal)
        } else {
            self.favButton.setImage(#imageLiteral(resourceName: "notfav"), for: .normal)
        }
    
    }
}

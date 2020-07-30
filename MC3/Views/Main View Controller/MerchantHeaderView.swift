//
//  MerchantHeaderView.swift
//  MC3
//
//  Created by Muhammad Thirafi on 29/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

protocol MerchantHeaderViewDelegate {
    func favDidTapped()
    func backButtView()
}

class MerchantHeaderView: UIView {
    
    var delegate: MerchantHeaderViewDelegate?
    static let height: CGFloat = 261
    private var phoneNumber: String = "0218641727"

    
    private var merchant: Merchant?{
        didSet{
            nameMerchant.configureHeadingLabel(title: merchant!.name, fontSize: 24, textColor: .white)
            labelBaru.text = merchant?.name
            print("VIEW",merchant)
        }
    }
    
    private var labelBaru: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Bebas",textColor: .white)
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal), for: .normal)
        button.setSize(width: 24, height: 24)
        button.addTarget(self, action: #selector(backButt), for: .touchUpInside)
        return button
    }()
    
    private lazy var favButton: UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "notfav"), for: .normal)
        button.addTarget(self, action: #selector(favisTapped), for: .touchUpInside)
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
    
    private lazy var ratingView: UIView = {
        let view = UIView()
        view.configureRatingView(withRating: "5", textColor: .white)
        return view
    }()
    
    private lazy var reviewerLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "(300 Review)", fontSize: 12, textColor: .white)
        return label
    }()
    
    //MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(backButton) {
            self.backButton.setAnchor(top: self.safeAreaLayoutGuide.topAnchor, left: self.leftAnchor, paddingTop: 8, paddingLeft: 16)
//            self.backButton.alpha = 0
        }
        self.addSubview(labelBaru) {
            self.labelBaru.setCenterXYAcnhor(in: self)
        }
        self.addSubview(favButton) {
            self.favButton.setAnchor(top: self.safeAreaLayoutGuide.topAnchor, right: self.rightAnchor, paddingTop: 8, paddingRight: 16)
        }
        
        self.addSubview(nameMerchant) {
            self.nameMerchant.setAnchor(top: self.backButton.bottomAnchor, left: self.leftAnchor, paddingTop: 80, paddingLeft: 10)
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
        
        self.backgroundColor = .black
        self.configureRoundedCorners(corners: [.bottomLeft,.bottomRight], radius: 25)
        self.configureShadow(shadowColor: .lightGray, radius: 6)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - FUNCTIONs
    
    @objc private func favisTapped(_ button: UIButton){
        button.isSelected = !button.isSelected
        if button.isSelected == true{
            button.setImage(#imageLiteral(resourceName: "addToFavoriteButton"), for: .normal)
        }else{
            button.setImage(#imageLiteral(resourceName: "notfav"), for: .normal)
        }
        delegate?.favDidTapped()
    }
    
    @objc private func callTapped(_ button: UIButton){
        let url:NSURL = URL(string: "+62\(self.phoneNumber)")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    func configureComponents(merchant: Merchant){
        self.merchant = merchant
        
    }
    
    @objc private func backButt() {
        delegate?.backButtView()

    }
    
}

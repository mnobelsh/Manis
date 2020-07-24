//
//  MerchantCollectionCell.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 22/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit
import ChameleonFramework


class MerchantCollectionCell: UICollectionViewCell {
    
    static let identifier = "MerchantCell"

    var data: Merchant? = nil {
        didSet {
            if let data = data {
                nameLabel.text = data.name
            }
        }
    }
    
    private var descriptionContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9165894985, green: 0.9167430997, blue: 0.9165692329, alpha: 1)
        view.configureRoundedCorners(corners: [.topLeft,.topRight], radius: 3)
        view.configureRoundedCorners(corners: [.bottomLeft,.bottomRight], radius: 10)
        return view
    }()
    private var merchantImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBackground
        imageView.configureRoundedCorners(corners: [.topLeft,.topRight], radius: 10)
        imageView.image = #imageLiteral(resourceName: "dessert_dummy")
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    var rankLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "1", fontSize: 20, textColor: UIColor.white)
        label.setSize(width: 50, height: 50)
        label.textAlignment = .center
        return label
    }()
    private lazy var rankNumberView: UIView = {
        let view = UIView()
        view.setSize(width: 70, height: 70)
        view.configureRoundedCorners(corners: [.allCorners], radius: 8)
        view.backgroundColor = UIColor.randomFlat()
        view.addSubview(rankLabel) {
            self.rankLabel.setCenterXYAcnhor(in: view)
            self.rankLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn: view.backgroundColor, isFlat: true)
        }
        return view
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Merchant Name", fontSize: 12, textColor: .black)
        label.setSize(height: 25)
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        self.configureRoundedCorners(corners: [.allCorners], radius: 10)
        self.configureShadow(shadowColor: .lightGray, radius: 5)
        
    }
    
    func configureTrendingCell() {
        self.addSubview(rankNumberView) {
            self.rankNumberView.configureRoundedCorners(corners: [.allCorners], radius: 8)
            self.rankNumberView.setCenterYAnchor(in: self)
            self.rankNumberView.setAnchor(left: self.leftAnchor, paddingLeft: 14)
        }
        
        self.addSubview(nameLabel) {
            self.nameLabel.configureHeadingLabel(title: self.nameLabel.text!, fontSize: 16, textColor: .black)
            self.nameLabel.setAnchor(top: self.rankNumberView.topAnchor, right: self.rightAnchor, left: self.rankNumberView.rightAnchor, paddingTop: 8, paddingLeft: 16)
            self.nameLabel.setSize(height: 35)
        }
        
    }
    
    func configureMerchantCell() {
        
        self.addSubview(descriptionContainerView) {
            self.descriptionContainerView.setAnchor(right: self.rightAnchor, bottom: self.bottomAnchor, left: self.leftAnchor)
            self.descriptionContainerView.setSize(height: 55)
            
            self.descriptionContainerView.addSubview(self.nameLabel) {
                self.nameLabel.setAnchor(top: self.descriptionContainerView.topAnchor, right: self.descriptionContainerView.rightAnchor, left: self.descriptionContainerView.leftAnchor, paddingLeft: 4)
            }
        }
        
        self.addSubview(merchantImageView) {
            self.merchantImageView.setAnchor(top: self.topAnchor, right: self.rightAnchor, bottom: self.descriptionContainerView.topAnchor, left: self.leftAnchor)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

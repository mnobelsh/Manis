//
//  MerchantCollectionCell.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 22/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit


class MerchantCollectionCell: UICollectionViewCell {
    
    static let identifier = "MerchantCell"

    var data: Merchant? = nil {
        didSet {
            if let data = data {
                nameLabel.text = data.name
            }
        }
    }
    
//    var descriptionContainerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 0.4040560788)
//        view.configureRoundedCorners(corners: [.topLeft,.topRight], radius: 3)
//        view.configureRoundedCorners(corners: [.bottomLeft,.bottomRight], radius: 10)
//        return view
//    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Merchant Name", fontSize: 12, textColor: .black)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        self.configureRoundedCorners(corners: [.allCorners], radius: 10)
        self.configureShadow(shadowColor: .black, radius: 2)

        
    }
    
    func configureSmallCell() {
//        self.addSubview(self.nameLabel) {
//            self.nameLabel.setCenterXYAcnhor(in: self)
//        }
    }
    
    func configureLargeCell() {
//        self.addSubview(descriptionContainerView) {
//            self.descriptionContainerView.setAnchor(right: self.rightAnchor, bottom: self.bottomAnchor, left: self.leftAnchor)
//            self.descriptionContainerView.setSize(height: 70)
//
//            self.addSubview(self.nameLabel) {
//                self.nameLabel.setAnchor(top: self.descriptionContainerView.topAnchor, right: self.descriptionContainerView.rightAnchor, left: self.descriptionContainerView.leftAnchor, paddingTop: 8, paddingRight: 8, paddingLeft: 8)
//            }
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

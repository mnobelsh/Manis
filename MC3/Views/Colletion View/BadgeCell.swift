//
//  BadgeCell.swift
//  MC3
//
//  Created by Muhammad Thirafi on 04/08/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

class BadgeCell: UICollectionViewCell {
    static let identifier = "badgecells"
    var a: Int = 5
    
//    var dataBadge: Badge? {
//        didSet{
//            imageBadge.image = dataBadge!.badgeImg
//            labelBadge.text = dataBadge!.badgeName
//        }
//    }
    
    private lazy var imageBadge: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "bigBadge3")
        
        return img
    }()
    
    private lazy var labelBadge: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Great Taste", fontSize: 12, textColor: .black)
        return label
    }()
    
    private lazy var countBadge: UILabel = {
        let label = UILabel()
        label.text = String(a)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.addSubview(imageBadge){
            self.imageBadge.setAnchor(top: self.topAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, left: self.leftAnchor, paddingTop: 8, paddingRight: 8, paddingBottom: 8, paddingLeft: 8)
        }
        
        self.addSubview(labelBadge){
            self.labelBadge.setAnchor(top: self.imageBadge.bottomAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, left: self.leftAnchor, paddingTop: 8, paddingRight: 8, paddingBottom: 8, paddingLeft: 8)
        }
        
        self.addSubview(countBadge){
            self.countBadge.setAnchor(top: self.labelBadge.topAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, left: self.leftAnchor, paddingTop: 8, paddingRight: 8, paddingBottom: 8, paddingLeft: 8)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

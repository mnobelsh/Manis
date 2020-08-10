//
//  DetailMerchantCollectionViewCell.swift
//  MC3
//
//  Created by Muhammad Thirafi on 04/08/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

class MerchantPropertiesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = UUID().uuidString
        
    var badgeData: Badge? {
        didSet{
            if let badgeData = badgeData {
                
                switch badgeData.type {
                    case .cleanIngredients:
                        self.badgeImage.image = #imageLiteral(resourceName: "bigBadge1")
                    case .cleanTools:
                        self.badgeImage.image = #imageLiteral(resourceName: "bigBadge3")
                    case .greatTaste:
                        self.badgeImage.image = #imageLiteral(resourceName: "bigBadge2")
                }
                
                self.badgeLabel.text = badgeData.title
                self.badgeCount.text = String(badgeData.count)
                
            }
        }
    }
    
    var photoData: UIImage!

    
    private var badgeImage: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "smallBadge2")
        img.setSize(width:72 ,height: 72)
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        
        
        return img
    }()

    private var badgeLabel: UILabel = {
        let label = UILabel()
        label.configureTextLabel(title: "Badge Title", fontSize: 12, textColor: .black)
        label.setSize(height: 15)
        return label
    }()

    private var badgeCount: UILabel = {
        let label = UILabel()
        label.configureTextLabel(title: "0", fontSize: 12, textColor: .black)
        label.setSize(height: 15)
        return label
    }()
    
    //MARK: - PHOTOS
    private var photoImage: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "doger")
        img.setSize(width:130  ,height: 130)
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        img.configureRoundedCorners(corners: [.allCorners], radius: 8)
        return img
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red

//        self.configureRoundedCorners(corners: [.allCorners], radius: 8)
//        self.configureShadow(shadowColor: .darkGray, radius: 2)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    
    func configBadgeCV(){
        self.backgroundColor = .clear
        self.addSubview(badgeImage){
            self.badgeImage.setAnchor(top: self.topAnchor,paddingTop: 2)
            self.badgeImage.setCenterXAnchor(in: self)
        }
        self.addSubview(badgeLabel){
            self.badgeLabel.setAnchor(top: self.badgeImage.bottomAnchor,paddingTop: 2)
            self.badgeLabel.setCenterXAnchor(in: self.badgeImage)
        }

        self.addSubview(badgeCount){
            self.badgeCount.setAnchor(top: self.badgeLabel.bottomAnchor,paddingTop: 2)
            self.badgeCount.setCenterXAnchor(in: self.badgeLabel)
        }
        
    }
    
    func configPhotoCV(){
        self.addSubview(photoImage){
            self.photoImage.setAnchor(top: self.topAnchor,paddingTop: 2)
            self.photoImage.setCenterXAnchor(in: self)
        }
    }
}

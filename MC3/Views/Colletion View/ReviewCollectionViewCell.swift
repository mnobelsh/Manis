//
//  ReviewCollectionViewCell.swift
//  MC3
//
//  Created by Muhammad Thirafi on 24/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//
//
//import UIKit
//
//class ReviewCollectionViewCell: UICollectionViewCell {
//    static let identifier  = "ReviewCell"
//
//    var data: Review? = nil{
//        didSet {
//            if let data = data {
//                userNameLabel.text = data.userName
//                self.addSubview(userNameLabel){
//                    self.setCenterXYAcnhor(in: self)
//                }
//            }
//        }
//    }
//
//    private var userNameLabel: UILabel = {
//        let label = UILabel()
//        label.configureHeadingLabel(title: "Review Name", fontSize: 12, textColor: .black)
//        return label
//    }()
//    
//    private var rateImg: UIImage = {
//        let img = UIImage()
//        return img
//    }()
//    
//    private var badgeImg: UIImage = {
//        let img = UIImage()
//        return img
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.backgroundColor = .black
//        self.configureRoundedCorners(corners: [.allCorners], radius: 8)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}


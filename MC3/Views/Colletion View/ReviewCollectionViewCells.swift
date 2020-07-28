//
//  ReviewCollectionViewCells.swift
//  MC3
//
//  Created by Muhammad Thirafi on 24/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

class ReviewCollectionViewCells: UICollectionViewCell, UITextViewDelegate {
    static let identifier = "ReviewCells"
    
    var details: Review? = nil {
        didSet {
            if let details = details {
                nameLabel.text = details.userName

            }
        }
    }
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Review Name", fontSize: 12, textColor: .black)
        return label
    }()
    
    //STARS
    private lazy var starButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.tintColor = .systemYellow
        
        button.contentMode = .scaleAspectFit
        button.backgroundColor = .clear
        button.isUserInteractionEnabled = false
        //add target
        
        return button
    }()
    
    private var stars: [UIButton]!
    private var userRating: Int = 0
    
    func configureStar(rating: Int) -> [UIButton] {
        var buttonSet: [UIButton] = []
        
        for _ in 0..<rating {
            buttonSet.append(starButton)
        }
        return buttonSet
    }
    
    private lazy var stackStar: UIStackView = {
        self.stars = configureStar(rating: 5)
        print("DEBUGS Rating")
        
        let stack = UIStackView(arrangedSubviews: stars)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 4
        return stack
    }()

    
    private lazy var badgeGreatTaste: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "moon.stars")
        return img
    }()
    
    private lazy var badgeCleanTools: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "starolife")
        return img
    }()
    
    private lazy var badgeCleanIce: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "wand.and.stars")
        return img
    }()
    
    private lazy var stackBadges: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [badgeGreatTaste, badgeCleanTools, badgeCleanIce])
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var commentView: UITextView = {
        let textVIew = UITextView()
        textVIew.text = "Enak es cendolnya udah gitu abangnya baik pas diajak ngobrol ramah terus padahal saya banyak mau banget minta nambah gula arennya lah, minta sendoknya dibersihin dulu"
        textVIew.textColor = .black
        textVIew.translatesAutoresizingMaskIntoConstraints = true
        textVIew.layer.cornerRadius = 10
        textVIew.isScrollEnabled = false
        textVIew.sizeToFit()
        textVIew.isEditable = false
        textVIew.delegate = self
        return textVIew
    }()
    
    private lazy var reviewPhotos: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "esdoger2.JPG" )
        img.setSize(width: 99, height: 123)
        
        return img
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.configureRoundedCorners(corners: [.allCorners], radius: 8)
        self.configureShadow(shadowColor: .darkGray, radius: 2)
    }
    
    func configureCells(){
        //USERNAME
        self.addSubview(nameLabel){
            self.nameLabel.setAnchor(top: self.topAnchor, right: self.rightAnchor, left: self.leftAnchor, paddingTop: 8, paddingLeft: 8)
        }
        
        //RATING
        self.addSubview(stackStar){
            self.stackStar.setAnchor(top: self.nameLabel.bottomAnchor, left: self.leftAnchor, paddingTop: 8, paddingRight: 8,  paddingLeft: 8)

        }
        
        //BADGE
        self.addSubview(stackBadges){
            self.stackBadges.setAnchor(top: self.stackStar.bottomAnchor, left: self.leftAnchor, paddingTop: 8, paddingRight: 8, paddingBottom: 8, paddingLeft: 8)
        }
        
        //Comment Details
        self.addSubview(commentView){
            self.commentView.setAnchor(top: self.stackBadges.bottomAnchor,right: self.rightAnchor, left: self.leftAnchor , paddingTop: 8, paddingRight: 8, paddingBottom: 8, paddingLeft: 8)
        }
        
        //Photos
        self.addSubview(reviewPhotos){
            self.reviewPhotos.setAnchor(top: self.commentView.bottomAnchor, left: self.leftAnchor, paddingTop: 8, paddingRight: 8, paddingBottom: 8, paddingLeft: 8)
        }
    }
    
//    func configureStarRating(rate: Double){
//        //RATING
//                var buttonArray: [String] = []
//                var rating = rate
//
//
////        for index in 0...Int(rating.round(.down)) {
////                    buttonArray.append("Button\(index)")
////                }
//
//        for (index,element) in buttonArray.enumerated(){
//            let oneBtn: UIButton = {
//                let button = UIButton()
//                button.setImage(UIImage(systemName: "star"), for: .normal)
//                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//                button.tag = index
//                return button
//            }()
//            self.addSubview(stackStar){
//                self.stackStar.addArrangedSubview(oneBtn)
//                self.stackStar.setAnchor(top: self.nameLabel.bottomAnchor, left: self.leftAnchor, paddingTop: 8, paddingRight: 8,  paddingLeft: 8)
//                    }
//                    print(index)
//
//        //            if buttonArray.count >= 4{
//        //                break
//        //            }
//                }
//    }
    
    func whenTapped(){
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


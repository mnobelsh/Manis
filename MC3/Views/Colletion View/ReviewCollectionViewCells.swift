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
    
    var starsButton: UIButton!
    private var stars: [UIButton]!
    let imagePicker = UIImagePickerController()
    
    var userRating: Int = 0
        
    //
    func configureStar(rating: Int) -> [UIButton] {
        var buttonSet: [UIButton] = []

        for _ in 0..<rating {
            starsButton = UIButton()
            starsButton.setImage(UIImage(named: "SmallSelectedStar"), for: .normal)
            starsButton.contentMode = .scaleAspectFit
            starsButton.backgroundColor = .clear
            starsButton.isUserInteractionEnabled = false
            buttonSet.append(starsButton)
        }
        return buttonSet
    }

    private lazy var stackStar: UIStackView = {
        print("DEBUGS Rating")
        
        stars = configureStar(rating: 5)

        let stack = UIStackView(arrangedSubviews: stars)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 4
        return stack
    }()
    
    private lazy var badgeGreatTaste: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "smallBadge2")
        return img
    }()
    
    private lazy var badgeCleanTools: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "smallBadge3")
        return img
    }()
    
    private lazy var badgeCleanIce: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "smallBadge1")
        return img
    }()
    
    private lazy var stackBadges: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [badgeGreatTaste, badgeCleanTools, badgeCleanIce])
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        stack.spacing = 8
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
        img.image = #imageLiteral(resourceName: "doger")
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

    func whenTapped(){
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


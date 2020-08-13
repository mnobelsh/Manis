//
//  MerchantCollectionCell.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 22/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit


class MerchantCollectionCell: UICollectionViewCell {
    
    static let identifier = UUID().uuidString

    let userLocation = LocationHandler.shared.manager.location
    var data: Merchant? = nil {
        didSet {
            if let data = data {
                nameLabel.text = data.name
                addressLabel.text = data.address
                lovedLabel.text = "By \(data.lovedBy) Peoples"
                merchantImageView.image = data.headerPhoto ?? #imageLiteral(resourceName: "default no photo")

                let distance = data.location.distance(from: userLocation!).rounded()/1000
                distanceLabel.configureHeadingLabel(title: String(format: "%.2f Km", distance), fontSize: 9, textColor: .darkGray)
                ratingLabel.text = String(data.rating)

                guard let section = data.section else {return}
                switch section {
                case .nearby:
                    ratingView.isHidden = true
                    distanceLabel.isHidden = false
                case .rating:
                    ratingView.isHidden = false
                    distanceLabel.isHidden = true
                case .trendings:
                    distanceLabel.isHidden = true
                    ratingView.isHidden = true
                }
                
                FirebaseService.shared.fetchMerchantRating(forMerchantID: data.id) { (rating,_, error)  in
                    if let rating = rating {
                        self.ratingLabel.text = String(rating)
                    }
                    
                }

            }
        }
    }
    
    private var descriptionContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9496210217, green: 0.9497799277, blue: 0.9496001601, alpha: 1)
        view.configureRoundedCorners(corners: [.topLeft,.topRight], radius: 3)
        view.configureRoundedCorners(corners: [.bottomLeft,.bottomRight], radius: 10)
        return view
    }()
    private var merchantImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBackground
        imageView.configureRoundedCorners(corners: [.topLeft,.topRight], radius: 10)
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    var rank: Int? {
        didSet {
            rankNumberView.image = UIImage(named: "trending\(rank!)")
        }
    }
    private lazy var rankNumberView: UIImageView = {
        let view = UIImageView()
        view.setSize(width: 70, height: 70)
        view.configureRoundedCorners(corners: [.allCorners], radius: 8)
        view.image = UIImage(named: "trending1")
        return view
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    private var addressLabel: UILabel = {
        let label = UILabel()
        label.configureTextLabel(title: "Merchant's Address", fontSize: 9, textColor: .darkGray)
        label.setSize(height: 15)
        return label
    }()
    
    private var lovedLabel: UILabel = {
        let label = UILabel()
        label.configureTextLabel(title: "By 1000 Peoples", fontSize: 14, textColor: .darkGray)
        return label
    }()
    private var loveImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "heart.fill")?.withTintColor(.systemPink, renderingMode: .alwaysOriginal))
        imageView.setSize(width: 20, height: 20)
        return imageView
    }()
    private var distanceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    private var ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.backgroundColor = .clear
        ratingLabel.textAlignment = .left
        ratingLabel.configureHeadingLabel(title: "0.0", fontSize: 9, textColor: .darkGray)
        ratingLabel.setSize(height: 14)
        return ratingLabel
    }()
    private lazy var ratingView: UIView = {
        let view = UIView()
        view.configureRatingView(ratingLabel: ratingLabel)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        self.configureRoundedCorners(corners: [.allCorners], radius: 10)
        self.configureShadow(shadowColor: .lightGray, radius: 5)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetComponent()
    }
    
    func configureTrendingCell() {
        self.addSubview(rankNumberView) {
            self.rankNumberView.configureRoundedCorners(corners: [.allCorners], radius: 8)
            self.rankNumberView.setCenterYAnchor(in: self)
            self.rankNumberView.setAnchor(left: self.leftAnchor, paddingLeft: 14)
        }
        
        self.addSubview(loveImageView) {
            self.loveImageView.setAnchor(bottom: self.rankNumberView.bottomAnchor, left: self.rankNumberView.rightAnchor, paddingBottom: 8, paddingLeft: 16)
        }

        self.addSubview(lovedLabel) {
            self.lovedLabel.setAnchor(right: self.rightAnchor, left: self.loveImageView.rightAnchor, paddingLeft: 8)
            self.lovedLabel.setCenterYAnchor(in: self.loveImageView)
        }
        
        self.addSubview(nameLabel) {
            self.nameLabel.configureHeadingLabel(title: self.nameLabel.text!, fontSize: 16, textColor: .black)
            self.nameLabel.setAnchor(top: self.rankNumberView.topAnchor, right: self.rightAnchor, left: self.rankNumberView.rightAnchor, paddingTop: 8, paddingLeft: 16)
        }
        
    }
    
    func configureMerchantCell() {
        
        self.addSubview(descriptionContainerView) {
            self.descriptionContainerView.setAnchor(right: self.rightAnchor, bottom: self.bottomAnchor, left: self.leftAnchor)
            self.descriptionContainerView.setSize(height: 65)
            
            self.descriptionContainerView.addSubview(self.nameLabel) {
                self.nameLabel.configureHeadingLabel(title: self.nameLabel.text ?? "Merchant Name", fontSize: 12, textColor: .black)
                self.nameLabel.setAnchor(top: self.descriptionContainerView.topAnchor, right: self.descriptionContainerView.rightAnchor, left: self.descriptionContainerView.leftAnchor, paddingTop: 6, paddingLeft: 4)
            }
            
            self.descriptionContainerView.addSubview(self.addressLabel) {
                self.addressLabel.setAnchor(top: self.nameLabel.bottomAnchor, right: self.descriptionContainerView.rightAnchor, left: self.descriptionContainerView.leftAnchor, paddingTop: 6, paddingLeft: 4)
            }

        }
        
        self.addSubview(merchantImageView) {
            self.merchantImageView.setAnchor(top: self.topAnchor, right: self.rightAnchor, bottom: self.descriptionContainerView.topAnchor, left: self.leftAnchor)
        }
        
        self.addSubview(distanceLabel) {
            self.distanceLabel.setSize(width: 50, height: 12)
            self.distanceLabel.setAnchor(right: self.rightAnchor, bottom: self.bottomAnchor, paddingRight: 4, paddingBottom: 8)
        }
        
        self.addSubview(ratingView) {
            self.ratingView.setAnchor(right: self.rightAnchor, bottom: self.bottomAnchor, paddingRight: 4, paddingBottom: 8)
        }
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func resetComponent() {
        self.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
    }
    
}

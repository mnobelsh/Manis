//
//  SearchResultCell.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 27/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

class MerchantTableCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = UUID().uuidString
    
    var merchant: Merchant? {
        didSet {
            guard let merchant = merchant else {return}
            merchantImageView.image = #imageLiteral(resourceName: "default no photo")
            merchantNameLabel.text = merchant.name
            ratingLabel.text = String(merchant.rating)
            
            if merchant.section == MainCollectionViewSection.nearby {
                let distance = Int(merchant.location.distance(from: LocationHandler.shared.manager.location!).rounded())
                locationLabel.text = "\(distance) m"
            } else {
                locationLabel.text = merchant.address
            }
        }
    }
    
    private var merchantImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBackground
        imageView.configureRoundedCorners(corners: [.allCorners], radius: 6)
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private var merchantNameLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Merchant Name", fontSize: 18, textColor: .black)
        return label
    }()
    private var locationLabel: UILabel = {
        let label = UILabel()
        label.configureTextLabel(title: "Merchant Location", fontSize: 14, textColor: .darkGray)
        return label
    }()
    private var ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.backgroundColor = .clear
        ratingLabel.configureHeadingLabel(title: "0.0", fontSize: 14, textColor: .darkGray)
        ratingLabel.textAlignment = .left
        return ratingLabel
    }()
    private lazy var ratingView: UIView = {
        let view = UIView()
        view.configureRatingView(ratingLabel: ratingLabel)
        return view
    }()
    private let separator: UIView = {
        let view = UIView()
        view.setSize(height: 1.2)
        view.backgroundColor = #colorLiteral(red: 0.8790971637, green: 0.8792449236, blue: 0.8790777326, alpha: 1)
        view.configureRoundedCorners(corners: [.allCorners], radius: 0.6)
        return view
    }()
    
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetComponents()
    }
    
    // MARK: - Helpers
    private func resetComponents() {
        self.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
    }
    
    func configureComponents() {
        self.addSubview(merchantImageView) {
            self.merchantImageView.setSize(width: 85, height: 85)
            self.merchantImageView.setAnchor(left: self.leftAnchor,paddingLeft: 16)
            self.merchantImageView.setCenterYAnchor(in: self)
        }
        
        self.addSubview(separator) {
            self.separator.setAnchor(right: self.rightAnchor, bottom: self.bottomAnchor, left: self.merchantImageView.leftAnchor, paddingRight: 8)
        }
        
        self.addSubview(merchantNameLabel) {
            self.merchantNameLabel.setSize(height: 25)
            self.merchantNameLabel.setAnchor(top: self.merchantImageView.topAnchor, right: self.rightAnchor, left: self.merchantImageView.rightAnchor, paddingLeft: 16)
        }
        
        self.addSubview(locationLabel) {
            self.locationLabel.setSize(height: 30)
            self.locationLabel.setAnchor(top: self.merchantNameLabel.bottomAnchor, right: self.rightAnchor, left: self.merchantImageView.rightAnchor, paddingTop: 4, paddingLeft: 16)
        }
        
        self.addSubview(ratingView) {
            self.ratingView.setSize(width: 70)
            self.ratingView.setAnchor(top: self.locationLabel.bottomAnchor, bottom: self.merchantImageView.bottomAnchor,left: self.merchantImageView.rightAnchor, paddingTop: 4,  paddingLeft: 16)
        }
        

    }
    

}

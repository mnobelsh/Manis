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
    static let identifier = "MerchantTVCell"
    
    var merchant: Merchant? {
        didSet {
            merchantImageView.image = #imageLiteral(resourceName: "doger")
            merchantNameLabel.text = merchant?.name
            addressLabel.text = merchant?.address
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
    private lazy var merchantNameLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Merchant Name", fontSize: 18, textColor: .black)
        return label
    }()
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.configureTextLabel(title: "Merchant Address", fontSize: 14, textColor: .darkGray)
        return label
    }()
    private lazy var ratingView: UIView = {
        let view = UIView()
        view.configureRatingView(withRating: "4.7", textColor: .darkGray)
        return view
    }()
    
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(merchantImageView) {
            self.merchantImageView.setSize(width: 85, height: 85)
            self.merchantImageView.setAnchor(left: self.leftAnchor,paddingLeft: 16)
            self.merchantImageView.setCenterYAnchor(in: self)
        }
        
        self.addSubview(merchantNameLabel) {
            self.merchantNameLabel.setSize(height: 25)
            self.merchantNameLabel.setAnchor(top: self.merchantImageView.topAnchor, right: self.rightAnchor, left: self.merchantImageView.rightAnchor, paddingLeft: 16)
        }
        
        self.addSubview(addressLabel) {
            self.addressLabel.setSize(height: 30)
            self.addressLabel.setAnchor(top: self.merchantNameLabel.bottomAnchor, right: self.rightAnchor, left: self.merchantImageView.rightAnchor, paddingTop: 4, paddingLeft: 16)
        }
        
        self.addSubview(ratingView) {
            self.ratingView.setSize(width: 50)
            self.ratingView.setAnchor(top: self.addressLabel.bottomAnchor, bottom: self.merchantImageView.bottomAnchor,left: self.merchantImageView.rightAnchor, paddingTop: 4,  paddingLeft: 16)
        }
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

}

//
//  DessertCategoryCell.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 24/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

class DessertCategoryCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "DessertCellIdentifier"
    
    var dessert: String? = nil {
        didSet {
            titleLabel.text = dessert
        }
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Dessert category", fontSize: 16, textColor: .black)
        return label
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemTeal
        self.configureRoundedCorners(corners: [.allCorners], radius: 8)
        self.addSubview(titleLabel) {
            self.titleLabel.setCenterXYAcnhor(in: self)
        }
        self.configureShadow(shadowColor: .lightGray, radius: 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
}

//
//  CustomCollectionViewCell.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 26/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit


class SortingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCell"
    
    var cellData: Sorting? {
        didSet {
            titleLabel.text = cellData!.title
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Sort By", fontSize: 12, textColor: UIColor(contrastingBlackOrWhiteColorOn: self.backgroundColor, isFlat: true))
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.configureRoundedCorners(corners: [.allCorners], radius: 8)
        self.configureShadow(shadowColor: .lightGray, radius: 2)
        
        self.addSubview(titleLabel) {
            self.titleLabel.setAnchor(top: self.topAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, left: self.leftAnchor, paddingTop: 10, paddingRight: 10, paddingBottom: 10, paddingLeft: 10)
        }
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabelColorContrastToBackground() {
        self.titleLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn: self.backgroundColor, isFlat: true)
    }
    
}

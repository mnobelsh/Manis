//
//  SectionTitleView.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 23/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

protocol SectionTitleViewDelegate {
    func seeOnMapButtonDidTap()
    func seeAllButtonDidTap()
}

enum SectionTitleLinkType {
    case seeAll, seeOnMap, empty
}

class SectionTitleView: UICollectionReusableView {
    
    static let kind = UUID().uuidString
    static let identifier = UUID().uuidString
    
    var delegate: SectionTitleViewDelegate?
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var linkType: SectionTitleLinkType? {
        didSet {
            switch linkType! {
            case .seeAll:
                self.topRightButton.setTitle("See all", for: .normal)
                self.topRightButton.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
            case .seeOnMap:
                self.topRightButton.setTitle("See on map", for: .normal)
                self.topRightButton.addTarget(self, action: #selector(seeOnMapButtonTapped), for: .touchUpInside)
            case .empty :
                self.topRightButton.isHidden = true
            }
        }
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Section", fontSize: 20, textColor: .black)
        return label
    }()
    private var topRightButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemBlue
        button.setSize(width: 100, height: 30)
        button.setTitle("See all", for: .normal)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(topRightButton) {
            self.topRightButton.setCenterYAnchor(in: self)
            self.topRightButton.setAnchor(right: self.rightAnchor, paddingRight: 24)
        }
        
        self.addSubview(titleLabel) {
            self.titleLabel.setAnchor(left: self.leftAnchor, paddingLeft: 16)
            self.titleLabel.setCenterYAnchor(in: self)
        }
    }
    
    @objc private func seeAllButtonTapped() {
        delegate?.seeAllButtonDidTap()
    }
    
    @objc private func seeOnMapButtonTapped() {
        delegate?.seeOnMapButtonDidTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

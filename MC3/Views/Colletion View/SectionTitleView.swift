//
//  SectionTitleView.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 23/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

protocol SectionTitleViewDelegate {
    func linkButtonDidTapped()
}
enum SectionTitleLinkType {
    case seeAll, seeOnMap, empty
}

class SectionTitleView: UICollectionReusableView {
    
    static let kind = "SectionTitleSupplementary"
    static let identifier = "SectionTitleIdentifier"
    
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
                topRightButton.setTitle("See all", for: .normal)
            case .seeOnMap:
                topRightButton.setTitle("See on map", for: .normal)
            case .empty :
                topRightButton.isHidden = true
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
        button.setTitle("See All", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
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
    
    @objc private func buttonTapped() {
        delegate?.linkButtonDidTapped()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//
//  SectTitleView.swift
//  MC3
//
//  Created by Muhammad Thirafi on 03/08/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

protocol SectTitleViewDelegate {
    func linkButtonTap()
}

enum SectLinkType{
    case seeAll, empty
}

class SectTitleView: UICollectionReusableView {
    
    static let kind = "SectionTitleSupplementary"
    static let identifier = "SectionTitleIdentifier"

    var delegateTitle: SectTitleViewDelegate?

    var titles: String? {
        didSet {
            titleLabels.text = titles
        }
    }
    
    var linkTypes: SectLinkType? {
        didSet {
            switch linkTypes! {
            case .seeAll:
                topRightButtons.setTitle("See all", for: .normal)
            case .empty :
                topRightButtons.isHidden = true
//            case .seeMap :
//                topRightButtons.setTitle("See on map", for: .normal)
            }
        }
    }
    
    private var titleLabels: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Section", fontSize: 20, textColor: .black)
        return label
    }()
    private var topRightButtons: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemBlue
        button.setSize(width: 100, height: 30)
        button.setTitle("See All", for: .normal)
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
            self.addSubview(topRightButtons) {
                self.topRightButtons.setCenterYAnchor(in: self)
                self.topRightButtons.setAnchor(right: self.rightAnchor, paddingRight: 24)
            }
            self.addSubview(titleLabels) {
                self.titleLabels.setAnchor(left: self.leftAnchor, paddingLeft: 16)
                self.titleLabels.setCenterYAnchor(in: self)
            }
        }
    
    @objc private func buttonTap() {
        delegateTitle?.linkButtonTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

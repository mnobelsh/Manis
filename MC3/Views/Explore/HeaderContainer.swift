//
//  HeaderContainer.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 07/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit
import ChameleonFramework

class ExploreHeaderContainer: UIView {
    
    var user: String = "" {
        didSet {
            greetingsLabel.configureTextLabel(string: user, textColor: UIColor(contrastingBlackOrWhiteColorOn: self.backgroundColor, isFlat: true))
        }
    }
    
    private lazy var greetingsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureRoundedCorners(corners: [.bottomLeft,.bottomRight], radius: 12)
        self.configureShadow(shadowColor: .darkGray, radius: 5)
        self.backgroundColor = .darkGray
        
        
        self.addSubview(greetingsLabel)
        greetingsLabel.setCenterXYAcnhor(in: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

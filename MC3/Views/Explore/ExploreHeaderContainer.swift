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
            greetingsLabel.configureTextLabel(title: "Hello, \(user)", textColor: UIColor(contrastingBlackOrWhiteColorOn: self.backgroundColor, isFlat: true))

        }
    }
    
    private lazy var greetingsLabel = UILabel()
    private lazy var nameTFView: UIView = {
        let view = UIView()
        let nameTF = UITextField()
        
        nameTF.configureInputTextField(placeholder: "Password", isSecureTextEntry: true, contrastColorTo: self.backgroundColor)
        view.configureTextFieldView(icon: UIImage(systemName: "lock.fill")!, textField: nameTF, contrastColorTo: self.backgroundColor)
        return view
    }()
    private lazy var button: UIButton = {
        let btn = UIButton(type: .system)
        btn.configureButton(title: "Login", backgroundColor: .darkGray, isContrastToBackGroundColor: true, cornerRadius: 8)
        btn.setSize(width: 320, height: 55)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureRoundedCorners(corners: [.bottomLeft,.bottomRight], radius: 12)
        self.configureShadow(shadowColor: .darkGray, radius: 10)
        self.backgroundColor = .white
        
        
        self.addSubview(nameTFView)
        nameTFView.setSize(width: 320)
        nameTFView.setCenterXYAcnhor(in: self)
        
        self.addSubview(greetingsLabel)
        greetingsLabel.setAnchor(bottom: nameTFView.topAnchor, paddingBottom: 25)
        greetingsLabel.setCenterXAnchor(in: self)
        
        self.addSubview(button)
        button.setAnchor(bottom: self.bottomAnchor, paddingBottom: 20)
        button.setCenterXAnchor(in: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

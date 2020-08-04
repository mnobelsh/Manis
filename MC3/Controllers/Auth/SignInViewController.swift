//
//  SignInViewController.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 21/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    private lazy var emailField: UITextField = {
        let email = UITextField()
        email.configureInputTextField(placeholder: "E-mail address", isSecureTextEntry: false)
        return email
    }()
    
    private lazy var textViewEmail: UIView = {
        let view = UIView()
        view.configureTextFieldView(icon: UIImage(systemName: "envelope.fill"), textField: emailField, errorLabel: "", contrastColorTo: .white)
        
        return view
    }()
    
    private lazy var passField: UITextField = {
       let pass = UITextField()
        pass.configureInputTextField(placeholder: "password", isSecureTextEntry: true)
        return pass
    }()
    
    private lazy var textViewPass: UIView = {
        let view = UIView()
        view.configureTextFieldView(icon: UIImage(systemName: "lock.fill"), textField: passField, errorLabel: "", contrastColorTo: .white)
        
        return view
    }()
    
    private lazy var stackk: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [textViewEmail,textViewPass])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 40
        
        return stack
    }()
    
    private lazy var button: UIButton = {
     let loginB = UIButton()
        loginB.configureButton(title: "Login", titleColor: .white, backgroundColor: .darkGray, isContrastToBackGroundColor: false, cornerRadius: 10)
        loginB.setSize(width: 170, height: 50)
        return loginB
    }()
    
    private lazy var labelRegist: UILabel = {
        let label = UILabel()
        label.configureTextLabel(title: "Don't have an account? Register here", fontSize: 14, textColor: .link)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToRegister(_:)))
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    @objc func goToRegister(_ button: UIButton){
        self.navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Login"
        view.addSubview(stackk){
            self.stackk.setCenterYAnchor(in: self.view)
            self.stackk.setAnchor(right: self.view.rightAnchor, left: self.view.leftAnchor, paddingRight: 20, paddingLeft: 20)
        }
        view.addSubview(button){
            self.button.setAnchor(top: self.stackk.bottomAnchor,paddingTop:100 , paddingRight: 20, paddingBottom: 30, paddingLeft: 20)
            self.button.setCenterXAnchor(in: self.view)
        }
        view.addSubview(labelRegist){
            self.labelRegist.setAnchor(top: self.button.bottomAnchor,paddingTop: 10, paddingRight: 20, paddingBottom: 30, paddingLeft: 20)
            self.labelRegist.setCenterXAnchor(in: self.view)
        }
    }
        // Do any additional setup after loading the view.
}

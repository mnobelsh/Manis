//
//  SignUpViewController.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 21/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private lazy var userNameField: UITextField = {
        let userName = UITextField()
        userName.configureInputTextField(placeholder: "Username", isSecureTextEntry: false)
        userName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        return userName
    }()

//        private lazy var errorLabel: UILabel = {
//            let label = UILabel()
//            label.configureTextLabel(title: "must filled username!", fontSize: 8, textColor: .red)
//
//            return label
//        }()
    
    private lazy var textViewUsername: UIView = {
        let view = UIView()
        view.configureTextFieldView(icon: UIImage(systemName: "person.fill"), textField: userNameField,errorLabel: "", contrastColorTo: .white)
        
        return view
    }()

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
        view.configureTextFieldView(icon: UIImage(systemName: "lock.fill"), textField: passField, errorLabel: "asdasdasdadas", contrastColorTo: .white)
        
        return view
    }()
    
    private lazy var confPassField: UITextField = {
       let pass = UITextField()
        pass.configureInputTextField(placeholder: "Confirm password", isSecureTextEntry: true)
        return pass
    }()
    
    private lazy var textViewConfPass: UIView = {
        let view = UIView()
        view.configureTextFieldView(icon: UIImage(systemName: "lock.fill"), textField: confPassField, errorLabel: "", contrastColorTo: .white)
        return view
    }()

    private lazy var stackk: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [textViewUsername, textViewEmail,textViewPass,textViewConfPass])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 40
        
        return stack
    }()
    
    private lazy var loginButton: UIButton = {
     let loginB = UIButton()
        loginB.configureButton(title: "Register", titleColor: .white, backgroundColor: .darkGray, isContrastToBackGroundColor: false, cornerRadius: 10)
        loginB.setSize(width: 170, height: 50)
        return loginB

    }()
    
    private lazy var labelRegist: UILabel = {
        let label = UILabel()
        label.configureTextLabel(title: "Already have an account? Login here", fontSize: 14, textColor: .link)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToLogin(_:)))
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    @objc func goToLogin(_ button: UIButton){
        self.navigationController?.pushViewController(SignInViewController(), animated: true)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Register"
        view.addSubview(stackk){
            self.stackk.setCenterYAnchor(in: self.view)
            self.stackk.setAnchor(right: self.view.rightAnchor, left: self.view.leftAnchor, paddingRight: 20, paddingLeft: 20)
        }
        view.addSubview(loginButton){
            self.loginButton.setAnchor(top: self.stackk.bottomAnchor,paddingTop:50 , paddingRight: 20, paddingBottom: 30, paddingLeft: 20)
            self.loginButton.setCenterXAnchor(in: self.view)
        }
        view.addSubview(labelRegist){
            self.labelRegist.setAnchor(top: self.loginButton.bottomAnchor,paddingTop: 10, paddingRight: 20, paddingBottom: 30, paddingLeft: 20)
            self.labelRegist.setCenterXAnchor(in: self.view)
        }
    }
    
    
    //MARK: - FUNCTIONS
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        switch sender {
        case self.userNameField:
            if self.userNameField.text == ""{
                view.configureTextFieldView(icon: nil, textField: userNameField, errorLabel: "Username must be fill!", contrastColorTo: nil)
            } else {
                view.configureTextFieldView(icon: nil, textField: userNameField, errorLabel: "NAIS", contrastColorTo: nil)
            }
        default: break

        }
    }
    
    
    @objc func registButtontTap(_ sender: Any){

    
    }



}

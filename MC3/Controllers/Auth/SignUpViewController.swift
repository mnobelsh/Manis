//
//  SignUpViewController.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 21/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private lazy var usernameTextField: UITextField = {
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
        view.configureTextFieldView(icon: UIImage(systemName: "person.fill"), textField: usernameTextField,errorLabel: "", contrastColorTo: .white)
        
        return view
    }()

    private lazy var emailTextField: UITextField = {
        let email = UITextField()
        email.configureInputTextField(placeholder: "E-mail address", isSecureTextEntry: false)
        return email
    }()
    
    private lazy var textViewEmail: UIView = {
        let view = UIView()
        view.configureTextFieldView(icon: UIImage(systemName: "envelope.fill"), textField: emailTextField, errorLabel: "", contrastColorTo: .white)
        return view
    }()
    
    private lazy var passTextField: UITextField = {
       let pass = UITextField()
        pass.configureInputTextField(placeholder: "password", isSecureTextEntry: true)
        return pass
    }()
    
    private lazy var textViewPass: UIView = {
        let view = UIView()
        view.configureTextFieldView(icon: UIImage(systemName: "lock.fill"), textField: passTextField, errorLabel: "asdasdasdadas", contrastColorTo: .white)
        
        return view
    }()
    
    private lazy var confPassTextField: UITextField = {
       let pass = UITextField()
        pass.configureInputTextField(placeholder: "Confirm password", isSecureTextEntry: true)
        return pass
    }()
    
    private lazy var textViewConfPass: UIView = {
        let view = UIView()
        view.configureTextFieldView(icon: UIImage(systemName: "lock.fill"), textField: confPassTextField, errorLabel: "", contrastColorTo: .white)
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
    
    private lazy var registerButton: UIButton = {
     let loginB = UIButton()
        loginB.configureButton(title: "Register", titleColor: .white, backgroundColor: .darkGray, isContrastToBackGroundColor: false, cornerRadius: 10)
        loginB.setSize(width: 170, height: 50)
        loginB.addTarget(self, action: #selector(registerButtontTap(_:)), for: .touchUpInside)
        return loginB
    }()
    
    private lazy var labelRegist: UIButton = {
        let button = UIButton(type: .system)
        var mutableAttributedString1 = NSMutableAttributedString(string: "Already have an account ? ", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.darkGray,
            NSAttributedString.Key.font : UIFont(name: "Avenir-Light", size: 16)!
        ])
        
        let mutableAttributedString2 = NSAttributedString(string: "Login here", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.systemBlue,
            NSAttributedString.Key.font : UIFont(name: "Avenir-Heavy", size: 16)!
        ])
        mutableAttributedString1.append(mutableAttributedString2)
        
        button.setAttributedTitle(mutableAttributedString1, for: .normal)
        button.addTarget(self, action: #selector(goToLogin(_:)), for: .touchUpInside)
        return button
    }()
    
    private let service = FirebaseService.shared
    
    @objc func goToLogin(_ button: UIButton){
        self.navigationController?.popToRootViewController(animated: true)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Register"
        
        setTransparentNavbar()
        self.navigationController?.navigationBar.isHidden = false
        let backButton = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(backToPreviousVC))
        self.navigationItem.setLeftBarButtonItems([backButton], animated: true)
        
        view.addSubview(stackk){
            self.stackk.setCenterYAnchor(in: self.view)
            self.stackk.setAnchor(right: self.view.rightAnchor, left: self.view.leftAnchor, paddingRight: 20, paddingLeft: 20)
        }
        view.addSubview(registerButton){
            self.registerButton.setAnchor(top: self.stackk.bottomAnchor,paddingTop:50 , paddingRight: 20, paddingBottom: 30, paddingLeft: 20)
            self.registerButton.setCenterXAnchor(in: self.view)
        }
        view.addSubview(labelRegist){
            self.labelRegist.setAnchor(top: self.registerButton.bottomAnchor,paddingTop: 10, paddingRight: 20, paddingBottom: 30, paddingLeft: 20)
            self.labelRegist.setCenterXAnchor(in: self.view)
        }
    }
    
    
    //MARK: - FUNCTIONS
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        switch sender {
        case self.usernameTextField:
            if self.usernameTextField.text == ""{
                view.configureTextFieldView(icon: nil, textField: usernameTextField, errorLabel: "Username must be fill!", contrastColorTo: nil)
            } else {
                view.configureTextFieldView(icon: nil, textField: usernameTextField, errorLabel: "NAIS", contrastColorTo: nil)
            }
        default: break

        }
    }
    
    @objc private func backToPreviousVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func registerButtontTap(_ sender: Any){
        guard let username = usernameTextField.text else {return}
        guard let email = emailTextField.text else {return}
        guard let password = passTextField.text else {return}
        let userData: [String:Any] = [
            User.emailField : email,
            User.nameField : username,
            User.favoritesField : [String](),
            User.reviewsField : [String](),
            User.passwordField : password,
            User.profilePictureField : "profile"
        ]
        
        service.registerUser(userData: userData) { (data, error) in
            if let err = error {
                print("AUTH ERROR : ",err.localizedDescription)
            } else {
                guard let presentingVC = (self.presentingViewController as? UINavigationController)?.viewControllers.last as? MainViewController else {return}
                presentingVC.fetchUser()
                self.dismiss(animated: true)
            }
        }
    }



}

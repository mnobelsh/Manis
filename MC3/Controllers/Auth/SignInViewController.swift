//
//  SignInViewController.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 21/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
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
        view.configureTextFieldView(icon: UIImage(systemName: "lock.fill"), textField: passTextField, errorLabel: "", contrastColorTo: .white)
        
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
        loginB.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return loginB
    }()
    
    private let service = FirebaseService.shared
    
    private lazy var labelRegist: UIButton = {
        let button = UIButton(type: .system)
        var mutableAttributedString1 = NSMutableAttributedString(string: "Don't have an account ? ", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.darkGray,
            NSAttributedString.Key.font : UIFont(name: "Avenir-Light", size: 16)!
        ])
        
        let mutableAttributedString2 = NSAttributedString(string: "Register here", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.systemBlue,
            NSAttributedString.Key.font : UIFont(name: "Avenir-Heavy", size: 16)!
        ])
        mutableAttributedString1.append(mutableAttributedString2)
        
        button.setAttributedTitle(mutableAttributedString1, for: .normal)
        button.addTarget(self, action: #selector(goToRegister(_:)), for: .touchUpInside)
        return button
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Login"
        
        setTransparentNavbar()
        self.navigationController?.navigationBar.isHidden = false
        let backButton = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(backToPreviousVC))
        self.navigationItem.setLeftBarButtonItems([backButton], animated: true)
        
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
    
    @objc private func backToPreviousVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func goToRegister(_ button: UIButton){
        self.navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    @objc private func loginButtonTapped() {
        if let email = emailTextField.text, let password = passTextField.text {
            service.signIn(email: email, password: password) { (user, error) in
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
   
}

//
//  ChangePasswordViewController.swift
//  MC3
//
//  Created by Melina Dewi on 03/08/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    private lazy var currentPasswordField: UITextField = {
        let currentPassword = UITextField()
        currentPassword.configureInputTextField(placeholder: "Current Password", isSecureTextEntry: false)
        currentPassword.clearButtonMode = .whileEditing
        currentPassword.isSecureTextEntry = true
        return currentPassword
    }()
        
    private lazy var textViewCurrentPassword: UIView = {
        let view = UIView()
        view.configureTextFieldView(icon: UIImage(systemName: "lock.fill"), textField: currentPasswordField, errorLabel: "This field must be fill!", contrastColorTo: .white)
        view.setSize(height: 40)
        
        return view
    }()

    private lazy var newPasswordField: UITextField = {
        let newPassword = UITextField()
        newPassword.configureInputTextField(placeholder: "New Password", isSecureTextEntry: false)
        newPassword.clearButtonMode = .whileEditing
        newPassword.isSecureTextEntry = true
        return newPassword
    }()
        
    private lazy var textViewNewPassword: UIView = {
        let view = UIView()
        view.configureTextFieldView(icon: UIImage(systemName: "lock.fill"), textField: newPasswordField, errorLabel: "This field must be fill!", contrastColorTo: .white)
        view.setSize(height: 40)
        
        return view
    }()
    
    private lazy var repeatNewPasswordField: UITextField = {
        let repeatNewPassword = UITextField()
        repeatNewPassword.configureInputTextField(placeholder: "Repeat New Password", isSecureTextEntry: false)
        repeatNewPassword.clearButtonMode = .whileEditing
        repeatNewPassword.isSecureTextEntry = true
        return repeatNewPassword
    }()
        
    private lazy var textViewRepeatNewPassword: UIView = {
        let view = UIView()
        view.configureTextFieldView(icon: UIImage(systemName: "lock.fill"), textField: repeatNewPasswordField, errorLabel: "This field must be fill!", contrastColorTo: .white)
        view.setSize(height: 40)
        
        return view
    }()
 
    private lazy var stackk: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [textViewCurrentPassword, textViewNewPassword, textViewRepeatNewPassword])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 40
        
        return stack
    }()
    
    private lazy var button: UIButton = {
       let buttonSave = UIButton()
        buttonSave.configureButton(title: "Save", titleColor: .black, backgroundColor: .white, isContrastToBackGroundColor: true, cornerRadius: 10)
        buttonSave.setSize(width: 175, height: 50)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(saveDidTap(_:)))
        buttonSave.addGestureRecognizer(tapGesture)
        
        return buttonSave
    }()
    
    @objc func saveDidTap(_ button:UIButton) {
//        textViewUsername.showErrorTextField()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setTransparentNavbar()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .black
        
        view.addSubview(stackk){
            self.stackk.setCenterYAnchor(in: self.view)
            self.stackk.setAnchor(right: self.view.rightAnchor, left: self.view.leftAnchor, paddingTop: 100, paddingRight: 20, paddingLeft: 20)
        }
        
        view.addSubview(button){
            self.button.setAnchor(top: self.stackk.bottomAnchor, paddingTop: 50, paddingRight: 20, paddingBottom: 20, paddingLeft: 20)
            self.button.setCenterXAnchor(in: self.view)
        }
        
    }
}

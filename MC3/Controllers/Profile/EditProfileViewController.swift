//
//  EditProfileViewController.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 21/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    private lazy var profileImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "profilePictureBig")
        img.setSize(width: 150, height: 150)
        
        return img
    }()
    
    private lazy var labelChangePhoto:UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.configureTextLabel(title: "Change Photo", fontSize: 18, textColor: .link)
        label.setSize(height: 20)
        label.textAlignment = .center
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelPicker(_:)))
        label.addGestureRecognizer(tapGesture)
        
        return label
    }()
    
    private lazy var userNameField: UITextField = {
        let userName = UITextField()
        userName.configureInputTextField(placeholder: "Username", isSecureTextEntry: false)
        userName.clearButtonMode = .whileEditing
        return userName
    }()
        
    private lazy var textViewUsername: UIView = {
        let view = UIView()
        view.configureTextFieldView(icon: UIImage(systemName: "person.fill"), textField: userNameField, errorLabel: "Username must be fill!", contrastColorTo: .white)
        view.setSize(height: 40)
        
        return view
    }()

    private lazy var emailField: UITextField = {
        let email = UITextField()
        email.configureInputTextField(placeholder: "E-mail address", isSecureTextEntry: false)
        email.clearButtonMode = .whileEditing
        return email
    }()
    
    private lazy var textViewEmail: UIView = {
        let view = UIView()
        view.configureTextFieldView(icon: UIImage(systemName: "envelope.fill"), textField: emailField, errorLabel: "", contrastColorTo: .white)
        view.setSize(height: 40)
        
        return view
    }()
        
    private lazy var labelChangePass:UILabel = {
        let ChangePass = UILabel()
        ChangePass.isUserInteractionEnabled = true
        ChangePass.configureTextLabel(title: "Change Password", fontSize: 18, textColor: .link)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangePassword(_:)))
        ChangePass.addGestureRecognizer(tapGesture)
        
        return ChangePass
    }()
    
 
    private lazy var stackk: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [textViewUsername, textViewEmail])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 20
        
        return stack
    }()
    
    private lazy var button: UIButton = {
       let buttonSave = UIButton()
        buttonSave.configureButton(title: "Save", titleColor: .black, backgroundColor: UIColor(hexString: "FFAC60"), isContrastToBackGroundColor: true, cornerRadius: 10)
        buttonSave.setSize(width: 175, height: 50)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(saveButtonTapped(_:)))
        buttonSave.addGestureRecognizer(tapGesture)
        
        return buttonSave
    }()
    
    @objc func saveDidTap(_ button:UIButton) {
        textViewUsername.showErrorTextField()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setTransparentNavbar()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .black
        self.title = "Edit Profile"
        
        view.addSubview(profileImage){
            self.profileImage.setCenterXAnchor(in: self.view)
            self.profileImage.setAnchor(top: self.view.topAnchor, paddingTop: 120, paddingRight: 8, paddingBottom: 8, paddingLeft: 8)
        }
        
        view.addSubview(labelChangePhoto){
            self.labelChangePhoto.setCenterXAnchor(in: self.view)
            self.labelChangePhoto.setAnchor(top: self.profileImage.bottomAnchor, paddingTop: 8, paddingRight: 8, paddingBottom: 8, paddingLeft: 8)
        }
        
        view.addSubview(stackk){
            self.stackk.setAnchor(top: self.labelChangePhoto.bottomAnchor, right: self.view.rightAnchor, left: self.view.leftAnchor, paddingTop: 50, paddingRight: 20, paddingLeft: 20)
            self.stackk.setSize(height: 100)
        }
        
        view.addSubview(labelChangePass){
            self.labelChangePass.setAnchor(top: self.stackk.bottomAnchor, left: self.view.leftAnchor, paddingTop: 50, paddingRight: 20, paddingBottom: 20, paddingLeft: 20)
        }
        
        view.addSubview(button){
            self.button.setAnchor(top: self.labelChangePass.bottomAnchor, paddingTop: 50, paddingRight: 20, paddingBottom: 20, paddingLeft: 20)
            self.button.setCenterXAnchor(in: self.view)
        }
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
    }
    
    @objc func saveButtonTapped(_ button: UIButton){
        if textViewUsername.isEmptyTextField() {
            textViewUsername.showErrorTextField()
        } else {
            textViewUsername.hideErrorTextField()
        }
//        let ProfileVC = ProfileViewController()
//        self.navigationController?.pushViewController(ProfileVC, animated: true)
//        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapChangePassword(_ button: UIButton){
        self.navigationController?.pushViewController(ChangePasswordViewController(), animated: true)
    }
    
    @objc func labelPicker(_ sender: UILabel){
        print("DEBUGS : UILabel CLICKED")
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: {(label) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(label) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage, let data = pickedImage.pngData() {
            
            FirebaseService.shared.uploadUserProfileImage(forUserID: "uAidgM23qscUVc3JJqk6199fZT83", withImageData: data) { (error) in
                
                if let err = error {
                    print(err.localizedDescription)
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        }
        
    }
}


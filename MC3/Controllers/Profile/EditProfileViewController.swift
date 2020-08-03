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
        img.setSize(width: 120, height: 120)
        
        return img
    }()
    
    private lazy var labelChangePhoto:UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.configureTextLabel(title: "Change Photo", fontSize: 14, textColor: .link)
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
        
    private lazy var labelChangePass:UILabel = {
        let ChangePass = UILabel()
        ChangePass.configureTextLabel(title: "Change Password", fontSize: 14, textColor: .link)
        return ChangePass
    }()
    
        private lazy var stackk: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [textViewUsername, textViewEmail])
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fillEqually
            stack.spacing = 40
            
            return stack
        }()
    
    private lazy var button: UIButton = {
       let buttonSave = UIButton()
        buttonSave.configureButton(title: "Save", titleColor: .black, backgroundColor: UIColor(hexString: "9CE4E5"), isContrastToBackGroundColor: true, cornerRadius: 10)
        buttonSave.setSize(width: 170, height: 50)
        buttonSave.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
        return buttonSave
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setTransparentNavbar()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .black
        
        view.addSubview(profileImage){
            self.profileImage.setCenterXAnchor(in: self.view)
            self.profileImage.setAnchor(top: self.view.topAnchor, paddingTop: 150, paddingRight: 8, paddingBottom: 8, paddingLeft: 8)
        }
        
        view.addSubview(labelChangePhoto){
            self.labelChangePhoto.setAnchor(top: self.profileImage.bottomAnchor, right: self.view.rightAnchor,  left: self.view.leftAnchor, paddingTop: 8, paddingRight: 8, paddingBottom: 8, paddingLeft: 8)
        }
        
        view.addSubview(stackk){
            self.stackk.setCenterYAnchor(in: self.view)
            self.stackk.setAnchor(top: self.labelChangePhoto.bottomAnchor ,right: self.view.rightAnchor, left: self.view.leftAnchor, paddingRight: 20, paddingLeft: 20)
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
        let ProfileVC = ProfileViewController()
        self.navigationController?.pushViewController(ProfileVC, animated: true)
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
        guard let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        //imageView.image = pickedImage
        profileImage.image = pickedImage
        
        dismiss(animated: true, completion: nil)
    }
}

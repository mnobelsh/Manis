//
//  SignInViewController.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 21/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    private lazy var passwordTf: UITextField = {
        let tf = UITextField()
        tf.configureInputTextField(placeholder: "Password", isSecureTextEntry: true, contrastColorTo: self.view.backgroundColor)
        return tf
    }()
    
    private lazy var passwordView: UIView = {
       let view = UIView()
        view.configureTextFieldView(icon: UIImage(systemName: "lock")?.withRenderingMode(.alwaysOriginal), textField: passwordTf, contrastColorTo: self.view.backgroundColor)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(passwordView) {
            self.passwordView.setCenterXYAcnhor(in: self.view)
            self.passwordView.setAnchor(right: self.view.rightAnchor, left: self.view.leftAnchor, paddingRight: 20, paddingLeft: 20)
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

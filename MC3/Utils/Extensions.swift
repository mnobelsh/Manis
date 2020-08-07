//
//  Extensions.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 07/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase

extension UINavigationController {
   open override var preferredStatusBarStyle: UIStatusBarStyle {
      return topViewController?.preferredStatusBarStyle ?? .default
   }
}

extension UIViewController {
    func setTransparentNavbar() {
        let navbar = self.navigationController?.navigationBar
        navbar?.backgroundColor = .clear
        navbar?.shadowImage = UIImage()
        navbar?.setBackgroundImage(UIImage(), for: .default)
    }
    func hideNavbar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    func setBlackStatusBarStyle() {
        self.navigationController?.navigationBar.barStyle = .default
    }
    func setWhiteStatusBarStyle() {
        self.navigationController?.navigationBar.barStyle = .black
    }
    func setPlacemark(withLocation location: CLLocation,completion: @escaping(CLPlacemark) -> Void) {
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            if let placemark = placemarks?.first {
                DispatchQueue.main.async {
                    completion(placemark)
                }
            }
        }
    }
}

extension UILabel {
    func configureHeadingLabel(title: String, fontSize size: CGFloat? = nil, textColor color: UIColor? = nil) {
        self.font = UIFont(name: "Avenir-Black", size: size ?? 22)
        self.text = title
        self.textColor = color ?? UIColor.label
    }
    
    func configureTextLabel(title: String, fontSize size: CGFloat? = nil, textColor color: UIColor? = nil) {
        self.font = UIFont(name: "Avenir", size: size ?? 14)
        self.text = title
        self.textColor = color ?? UIColor.label
    }
    
    func configureCustomLabel(title: String, fontType: String, fontSize size: CGFloat? = nil, textColor color: UIColor? = nil) {
        self.font = UIFont(name: "Avenir-\(fontType)", size: size ?? 14)
        self.text = title
        self.textColor = color ?? UIColor.label
    }
}

extension UIView {
    
    func addSubview(_ view: UIView, completion: @escaping() -> Void) {
        self.addSubview(view)
        completion()
    }
    
    enum CornerType {
        case topLeft,topRight,bottomLeft,bottomRight,allCorners
    }
    func configureRoundedCorners(corners : [CornerType], radius: CGFloat) {
        var selectedCorners = [CACornerMask]()
        corners.forEach { (corner) in
            switch corner {
                case .allCorners:
                    selectedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner]
                case .bottomLeft:
                    selectedCorners.append(.layerMinXMaxYCorner)
                case .bottomRight:
                    selectedCorners.append(.layerMaxXMaxYCorner)
                case .topLeft:
                    selectedCorners.append(.layerMinXMinYCorner)
                case .topRight:
                    selectedCorners.append(.layerMaxXMinYCorner)
            }
        }
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = CACornerMask(selectedCorners)
    }
    
    func configureShadow(shadowColor color: UIColor, radius: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowOpacity = 0.85
    }
    
    func setAnchor(top: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat = 0, paddingRight: CGFloat = 0, paddingBottom: CGFloat = 0, paddingLeft: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
    }
    
    func setSize(width: CGFloat? = nil, height: CGFloat? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func setCenterXAnchor(in view: UIView, constant: CGFloat? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let constant = constant {
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
        } else {
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
    }
    
    func setCenterYAnchor(in view: UIView, constant: CGFloat? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let constant = constant {
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        } else {
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    }
    
    func setCenterXYAnchor(in view: UIView) {
        setCenterXAnchor(in: view)
        setCenterYAnchor(in: view)
    }
    
    func configureTextFieldView(icon: UIImage? = nil, textField tf: UITextField, errorLabel: String, contrastColorTo: UIColor? = nil) {
        self.setSize(height: 44)
        
        let border = UIView()
        border.setSize(height: 1)
        border.backgroundColor = contrastColorTo != nil ? UIColor(contrastingBlackOrWhiteColorOn: contrastColorTo!, isFlat: true) : .darkGray
        border.configureRoundedCorners(corners: [.allCorners], radius: 0.5)
        self.addSubview(border)
        
        if let icon = icon{
            let iconView = UIImageView(image: icon)
            iconView.contentMode = .scaleAspectFit
            iconView.setSize(width: 24, height: 24)
            
            if let contrastColor = contrastColorTo {
                iconView.tintColor = UIColor(contrastingBlackOrWhiteColorOn: contrastColor, isFlat: true)
            }
            self.addSubview(iconView)
            iconView.setCenterYAnchor(in: self)
            iconView.setAnchor(left: self.leftAnchor)
            
            self.addSubview(tf)
            tf.setCenterYAnchor(in: iconView)
            tf.setAnchor(right: self.rightAnchor, left: iconView.rightAnchor, paddingLeft: 16)
            
            let error = UILabel()
            error.configureTextLabel(title: "", fontSize: 10, textColor: .red)
            self.addSubview(error)
            error.setAnchor(top: tf.bottomAnchor,right: tf.rightAnchor,left: tf.leftAnchor , paddingTop: 15, paddingRight: 5, paddingBottom: 5, paddingLeft: 0)
            error.text = errorLabel
            error.isHidden = true
            error.tag = 500
            
            border.setAnchor(right: self.rightAnchor, bottom: self.bottomAnchor, left: iconView.rightAnchor, paddingLeft: 16)
        } else {
            self.addSubview(tf)
            tf.setAnchor(top: self.topAnchor, right: self.rightAnchor, bottom: border.topAnchor, left: self.leftAnchor, paddingTop: 8)
            
            border.setAnchor(right: self.rightAnchor, bottom: self.bottomAnchor, left: self.leftAnchor)
        }

    }
    
    func showErrorTextField(){
        for view in self.subviews {
            if view.tag == 500 {
                view.isHidden = false
            }
        }
    }
    
    func hideErrorTextField(){
        for view in self.subviews {
            if view.tag == 500 {
                view.isHidden = true
            }
        }
    }
    
    func isEmptyTextField() -> Bool{
        for view in self.subviews {
            if let textField = view as? UITextField {
                if textField.text == "" {
                    return true
                }
            }
        }
        return false
    }
    
    func checkEmptyTextField() {
        var isEmpty = false
        for view in self.subviews {
            if let textField = view as? UITextField {
                if textField.text == "" {
                    isEmpty = true
                }
            }
            if let errorLabel = view as? UILabel {
                if isEmpty {
                    errorLabel.isHidden = false
                } else {
                    errorLabel.isHidden = true
                }
            }
        }
    }
    
    func getTextFromTextField() -> String? {
        for view in self.subviews {
            if let textField = view as? UITextField {
                return textField.text
            }
        }
        return nil
    }
    
    func changeErrorLabelTextField(label: String){
        for view in self.subviews {
            if let errorLabel = view as? UILabel {
                errorLabel.text = label
            }
        }
    }
    
    func configureRatingView(ratingLabel: UILabel) {
        
        let starView = UIImageView(image: UIImage(systemName: "star.fill")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal))
        starView.contentMode = .scaleAspectFit
        starView.backgroundColor = .clear
        starView.setSize(width: 18, height: 18)
        
        self.addSubview(starView) {
            starView.setAnchor(left: self.leftAnchor)
            starView.setCenterYAnchor(in: self)
        }
        
        self.addSubview(ratingLabel) {
            ratingLabel.setAnchor(top: self.topAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, left: starView.rightAnchor, paddingTop: 4, paddingBottom: 4, paddingLeft: 4)
        }
        
    }
    
    func configureBadge(badge: UIImage,title: String,total: String){
        self.setSize(height: 120)
        let img = UIImageView(image: badge)
        img.contentMode = .scaleAspectFit
        img.backgroundColor = .clear
        
        self.addSubview(img){
            img.setAnchor(top: self.topAnchor,right: self.rightAnchor,left: self.leftAnchor, paddingTop: 0, paddingRight: 8, paddingBottom: 8, paddingLeft: 0)
            
        }
        
        let titlelabel = UILabel()
        titlelabel.backgroundColor = .clear
//        titlelabel.configureHeadingLabel(title: title, fontSize: 12, textColor: .black)
        titlelabel.font = UIFont(name: "Avenir-Medium", size: 12)
        titlelabel.text = title
        titlelabel.textColor = .black
        
        self.addSubview(titlelabel){
            titlelabel.setAnchor(top: img.bottomAnchor, paddingTop: 0)
            titlelabel.setCenterXAnchor(in: img)
        }
        
        let totalLabel = UILabel()
        totalLabel.backgroundColor = .clear
        totalLabel.font = UIFont(name: "Avenir-Medium", size: 12)
        totalLabel.text = total
        totalLabel.textColor = .black
        
        self.addSubview(totalLabel){
            totalLabel.setAnchor(top: titlelabel.bottomAnchor, paddingTop: 0)
            totalLabel.setCenterXAnchor(in: img)
        }
    }
}

extension UITextField {
    func configureInputTextField(placeholder: String, isSecureTextEntry: Bool, contrastColorTo: UIColor? = nil) {
        self.isSecureTextEntry = isSecureTextEntry ? true : false
        
        self.textAlignment = .left
        self.borderStyle = .none
        self.autocapitalizationType = .none
        self.font = UIFont(name: "Avenir-Heavy", size: 16)
        self.textColor = UIColor.darkGray
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            NSAttributedString.Key.font : UIFont(name: "Avenir-Light", size: 16)!,
            NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        
        if let contrastColor = contrastColorTo {
            let color = UIColor(contrastingBlackOrWhiteColorOn: contrastColor, isFlat: true)!
            self.textColor = color
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
                NSAttributedString.Key.font : UIFont(name: "Avenir-Light", size: 16)!,
                NSAttributedString.Key.foregroundColor : color])
        }

    }
}


extension UIButton {
    func configureButton(title: String, titleColor: UIColor? = nil, backgroundColor: UIColor, isContrastToBackGroundColor: Bool? = nil, cornerRadius: CGFloat? = nil) {
        self.setAttributedTitle(NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor : titleColor ?? UIColor.black, NSAttributedString.Key.font : UIFont(name: "Avenir-Heavy", size: 18)!]), for: .normal)
        self.backgroundColor = backgroundColor
        if let radius = cornerRadius {
            self.configureRoundedCorners(corners: [.allCorners], radius: radius)
        }
        
        if let isContrast = isContrastToBackGroundColor, titleColor == nil {
            let color = UIColor(contrastingBlackOrWhiteColorOn: self.backgroundColor, isFlat: true)!
            isContrast ?  self.setAttributedTitle(NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor : color, NSAttributedString.Key.font : UIFont(name: "Avenir-Heavy", size: 18)!]), for: .normal) : nil
        }

    }
}

//
//  AddReviewViewController.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 21/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

class AddReviewViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    //MARK: - CCOMPONENTS

    //Rating
    private lazy var ratingLabel: UILabel = {
        let alabel = UILabel()
        alabel.configureHeadingLabel(title: "Rating", fontSize: 20, textColor: .black)
        return alabel
    }()

    private lazy var badLabel: UILabel = {
        let label = UILabel()
        label.configureCustomLabel(title: "Very bad", fontType: "Book", fontSize: 12, textColor: .black)
        return label
    }()

    var starsButton: UIButton!
    private var stars: [UIButton]!
    let imagePicker = UIImagePickerController()
    
    var userRating: Int = 0

        
    //
    func configureStar(rating: Int) -> [UIButton] {
        var buttonSet: [UIButton] = []

        for _ in 0..<rating {
            starsButton = UIButton()
            starsButton.setImage(UIImage(named: "BigNotSelectedStar"), for: .normal)
            starsButton.contentMode = .scaleAspectFit
            starsButton.backgroundColor = .clear
            starsButton.isUserInteractionEnabled = true
            starsButton.addTarget(self, action: #selector(starDidTapped(_:)), for: .touchUpInside)
            buttonSet.append(starsButton)
        }
        return buttonSet
    }

    private lazy var stackStar: UIStackView = {
        print("DEBUGS Rating")
        
        stars = configureStar(rating: 5)

        let stack = UIStackView(arrangedSubviews: stars)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 4
        return stack
    }()
    
    @objc func starDidTapped(_ button: UIButton){
        stackStar.arrangedSubviews.forEach{ (buttonView) in
                let btn = buttonView as! UIButton
            btn.setImage(UIImage(named: "BigNotSelectedStar"), for: .normal)
        }
        
        let maxIndex = stackStar.arrangedSubviews.firstIndex(of: button)!
        userRating = maxIndex+1
        
        for idx in 0...maxIndex{
            stars[idx].setImage(UIImage(named: "BigSelectedStar"), for: .normal)
        }
        print("DEBUGS : \(userRating)")
        
    }

    private lazy var goodLabel: UILabel = {
        let label = UILabel()
        label.configureCustomLabel(title: "Very good", fontType: "Book", fontSize: 12, textColor: .black)
        return label
    }()

    private lazy var ratingStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [badLabel, stackStar , goodLabel])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 7

        return stack
    }()
    
    //Badges
    private lazy var badgesLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Badges", fontSize: 20, textColor: .black)
        return label
    }()
    
    private lazy var badge1: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bigBadge2"), for: .normal)
        button.addTarget(self, action: #selector(badgeDidTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func badgeDidTapped(_ button: UIButton){
        button.isSelected = !button.isSelected
        if button.isSelected == false {
            button.setImage(UIImage(named : "bigBadge2"), for: .normal)
        } else {
            button.setImage(UIImage(named : "selectedBadge2"), for: .normal)
        }
    }
    
    private lazy var badge2: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bigBadge3"), for: .normal)
        button.addTarget(self, action: #selector(badgeDidTapped2(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func badgeDidTapped2(_ button: UIButton){
        button.isSelected = !button.isSelected
        if button.isSelected == false {
           button.setImage(UIImage(named : "bigBadge3"), for: .normal)
       } else {
           button.setImage(UIImage(named : "selectedBadge3"), for: .normal)
       }
    }
    
    private lazy var badge3: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bigBadge1"), for: .normal)
        button.addTarget(self, action: #selector(badgeDidTapped3(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func badgeDidTapped3(_ button: UIButton){
        button.isSelected = !button.isSelected
        if button.isSelected == false {
            button.setImage(UIImage(named : "bigBadge1"), for: .normal)
        } else {
            button.setImage(UIImage(named : "selectedBadge1"), for: .normal)
        }
    }
    
    private lazy var badgesStacks: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [badge1,badge2,badge3])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 4
        
        return stack
    }()
    
    private lazy var badge1Label: UILabel = {
        let label = UILabel()
        label.configureCustomLabel(title: "Great Taste", fontType: "Heavy", fontSize: 12, textColor: .black)
        return label
    }()
    private lazy var badge2Label: UILabel = {
        let label = UILabel()
        label.configureCustomLabel(title: "Clean Tools", fontType: "Heavy", fontSize: 12, textColor: .black)
        return label
    }()
    private lazy var badge3Label: UILabel = {
        let label = UILabel()
        label.configureCustomLabel(title: "Clean Ice", fontType: "Heavy", fontSize: 12, textColor: .black)
        return label
    }()
    
    private lazy var badgesLabelStacks: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [badge1Label,badge2Label,badge3Label])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 50
        
        return stack
    }()
    
    //COMMENT
    private lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Comment", fontSize: 20, textColor: .black)
        return label
    }()
    
    private lazy var commentView: UITextView = {
        let textView = UITextView()
        textView.setSize( height: 145)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.font = UIFont(name: "Avenir-Medium", size: 12)
        textView.text = "Write your review here..."
        textView.textColor = UIColor.lightGray
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.sizeToFit()
        textView.layoutIfNeeded()
        
        return textView
    }()
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write your review here..."
            textView.textColor = UIColor.lightGray
        }
        let userInput: String
        userInput = textView.text
        print("DEBUGS : \(userInput)")
    }
    
    //PHOTOS
    
    private lazy var photoLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Photo", fontSize: 20, textColor: .black)
        return label
    }()
    
    private lazy var optionalLabel: UILabel = {
        let label = UILabel()
        label.configureCustomLabel(title: "(optional)", fontType: "Book", fontSize: 20, textColor: .black)
        return label
    }()
    
    private lazy var pickerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addPhotoButton"), for: .normal)
        button.contentMode = .scaleToFill
        button.setSize(width: 100, height: 125)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(picker(_:)), for: .touchUpInside)
        
        return button
    }()
    
    @objc func picker(_ button: UIButton){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: {(button) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(button) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        //imageView.image = pickedImage
        pickerButton.setImage(pickedImage, for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.configureButton(title: "Save", titleColor: .black, backgroundColor: UIColor(hexString: "#FFAC60"), cornerRadius: 8)
        button.setSize(width: 170, height: 50)
        button.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setTransparentNavbar()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .black
        self.title = "Add Review"
        
        view.addSubview(ratingLabel){
            self.ratingLabel.setAnchor(top: self.view.topAnchor, left: self.view.leftAnchor, paddingTop: 120, paddingRight: 15, paddingBottom: 15, paddingLeft: 15)
        }
        
        view.addSubview(ratingStack){
            self.ratingStack.setAnchor(top: self.ratingLabel.bottomAnchor, left: self.view.leftAnchor, paddingTop: 8, paddingRight: 15, paddingBottom: 15, paddingLeft: 15)
        }
        
        view.addSubview(badgesLabel){
            self.badgesLabel.setAnchor(top: self.ratingStack.bottomAnchor, left: self.view.leftAnchor, paddingTop: 15, paddingRight: 15, paddingBottom: 15, paddingLeft: 15)
        }
        
        view.addSubview(badgesStacks){
            self.badgesStacks.setAnchor(top: self.badgesLabel.bottomAnchor,right: self.view.rightAnchor, left: self.view.leftAnchor, paddingTop: 8, paddingRight: 15, paddingBottom: 15, paddingLeft: 15)
        }
        
        view.addSubview(badgesLabelStacks){
            self.badgesLabelStacks.setAnchor(top: self.badgesStacks.bottomAnchor,right: self.view.rightAnchor, left: self.view.leftAnchor, paddingTop: 4, paddingRight: 15, paddingBottom: 15, paddingLeft: 45)
        }
        
        view.addSubview(commentLabel){
            self.commentLabel.setAnchor(top: self.badgesLabelStacks.bottomAnchor, left: self.view.leftAnchor, paddingTop: 30, paddingRight: 15, paddingBottom: 10, paddingLeft: 15)
        }
        
        view.addSubview(commentView){
            self.commentView.setAnchor(top: self.commentLabel.bottomAnchor, right: self.view.rightAnchor,left: self.view.leftAnchor, paddingTop: 8, paddingRight: 15, paddingBottom: 15, paddingLeft: 15)
        }

        view.addSubview(photoLabel){
            self.photoLabel.setAnchor(top: self.commentView.bottomAnchor,left: self.view.leftAnchor, paddingTop: 15, paddingRight: 15, paddingBottom: 15, paddingLeft: 15)
        }
        
        view.addSubview(optionalLabel){
            self.optionalLabel.setAnchor(top: self.commentView.bottomAnchor, left: self.photoLabel.rightAnchor, paddingTop: 15, paddingRight: 15, paddingBottom: 15, paddingLeft: 5)
        }
        
        view.addSubview(pickerButton){
            self.pickerButton.setAnchor(top: self.photoLabel.bottomAnchor, left: self.view.leftAnchor, paddingTop: 8, paddingRight: 15, paddingBottom: 8, paddingLeft: 15)
        }
        
        view.addSubview(saveButton){
            self.saveButton.setAnchor(bottom: self.view.bottomAnchor, paddingRight: 20, paddingBottom: 30, paddingLeft: 20)
            self.saveButton.setCenterXAnchor(in: self.view)
        }
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        commentView.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func saveButtonTapped(_ button: UIButton){
        let backVC = AllReviewVC()
        self.navigationController?.pushViewController(backVC, animated: true)
//        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}

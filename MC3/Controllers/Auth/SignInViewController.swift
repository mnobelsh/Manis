//
//  SignInViewController.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 21/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    var starButton: UIButton!
    private var stars: [UIButton]!
    private var horizontalStack: UIStackView!
    
    var userRating: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stars = configureStar(rating: 5)
        
        horizontalStack = UIStackView(arrangedSubviews: stars)
        horizontalStack.alignment = .center
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fillEqually
        horizontalStack.spacing = 4
        horizontalStack.setSize(width: 150, height: 95)
        
        self.view.addSubview(horizontalStack) {
            self.horizontalStack.setCenterXYAcnhor(in: self.view)
        }
        
    }
    
    func configureStar(rating: Int) -> [UIButton] {
        var buttonSet: [UIButton] = []
        
        for _ in 0..<rating {
            starButton = UIButton()
            starButton.setImage(UIImage(systemName: "star.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
            starButton.contentMode = .scaleAspectFit
            starButton.backgroundColor = .clear
            starButton.isUserInteractionEnabled = true
            starButton.addTarget(self, action: #selector(starDidTapped(_:)), for: .touchUpInside)
            buttonSet.append(starButton)
        }

        return buttonSet
    }
    
    @objc func starDidTapped(_ button: UIButton) {
        
        horizontalStack.arrangedSubviews.forEach { (buttonView) in
            let btn = buttonView as! UIButton
            btn.setImage(UIImage(systemName: "star.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        }
        
        let maxIndex = horizontalStack.arrangedSubviews.firstIndex(of: button)!
        userRating = maxIndex+1
        
        for idx in 0...maxIndex {
            stars[idx].setImage(UIImage(systemName: "star.fill")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal), for: .normal)
        }
        
        print("USER RATING : \(userRating)")
    }
}

//
//  AvatarImageView.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 23/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

class AvatarImageView: UIView {
    
    private var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureAvatarView(avatarImage img: UIImage?, withDimension dimension: CGFloat) {
        
        self.frame.size = CGSize(width: dimension, height: dimension)
        self.setSize(width: dimension, height: dimension)
        self.configureShadow(shadowColor: .darkGray, radius: 4)
        self.configureRoundedCorners(corners: [.allCorners], radius: self.frame.width/2)
        
        imageView = UIImageView(image: img)
        imageView.contentMode = .scaleAspectFit

        imageView.layer.masksToBounds = true
        imageView.frame = self.bounds
        imageView.configureRoundedCorners(corners: [.allCorners], radius: self.frame.width/2)
        self.addSubview(imageView)

    }
}

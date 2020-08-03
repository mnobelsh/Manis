//
//  User.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 30/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import Foundation


struct User {
    
    static let userIDField = "userID"
    static let emailField = "email"
    static let passwordField = "password"
    static let nameField = "name"
    static let profilePicture = "profile_picture"
    
    let id: String
    let email: String
    let name: String
    let profilePicture: String
    let reviews: [Review]
    let favorites: [Merchant]
}

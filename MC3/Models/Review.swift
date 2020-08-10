//
//  Review.swift
//  MC3
//
//  Created by Muhammad Thirafi on 24/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import Foundation
import UIKit

struct Review: Hashable{
    
    static var reviewDetails: [Review] = []
    
    static let reviewIDField = "reviewID"
    static let userIDField = "userID"
    static let merchantIDField = "merchantID"
    static let ratingField = "rating"
    static let badgesField = "badges"
    static let detailsField = "details"
    
    let uuid = UUID().uuidString
    var id:String
    var userID:String
    var merchantID: String
    var rating: Double
    var badges: [Badge]
    var details: String

}

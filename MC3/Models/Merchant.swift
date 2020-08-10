//
//  Merchant.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 22/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import Foundation
import CoreLocation

struct Merchant: Hashable {
    
    static let openingHoursField = "opening_hours"
    static let photosField = "photos"
    static let menuField = "menu"
    static let locationField = "location"
    static let lovedByField = "lovedBy"
    static let addressField = "address"
    static let nameField = "name"
    static let badgeField = "badges"
    static let phoneNumberField = "phone_number"
    static let ratingField = "rating"
    static let merchantIDField = "merchantID"
    
    let uuid = UUID().uuidString
    var id: String
    var name: String
    var address: String
    var lovedBy: Int
    var menu: [Menu]
    var badges: [Badge]
    var phoneNumber: String
    var rating: Double
    var section: MainCollectionViewSection? = nil
    var location: CLLocation
    
}


//struct Badge: Hashable {
//    static var badgeDetails:[Badge] = [Badge(badgeName: "Great Taste", badgeImg:#imageLiteral(resourceName: "bigBadge2") , counts: 15),Badge(badgeName: "Clean Tools", badgeImg: #imageLiteral(resourceName: "bigBadge3"),counts: 10),Badge(badgeName: "Clean Ice", badgeImg: #imageLiteral(resourceName: "bigBadge1"),counts: 8)]
//
//    var badgeName: String
//    var badgeImg: UIImage?
//    var counts: Int?
//}

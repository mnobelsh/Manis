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
    
    static var trendingsDessert: [Merchant] = [Merchant(id: UUID().uuidString, name: "Es Doger", address: "Jl. Serpong Raya 1", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),
                                               Merchant(id: UUID().uuidString, name: "Es Campur", address: "Jl. Serpong Raya 12", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),
                                               Merchant(id: UUID().uuidString, name: "Es Goyobod", address: "Jl. Serpong Raya 3", lovedBy: [], menu: [], badges: [], phoneNumber: "000")]
    static var nearbyMerchants: [Merchant] =  [Merchant(id: UUID().uuidString, name: "Es Cincau Mang Ucup", address: "Jl. Serpong Raya 10", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),
                                               Merchant(id: UUID().uuidString, name: "Es Teler Uhuy", address: "Jl. Serpong Raya 13", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),
                                               Merchant(id: UUID().uuidString, name: "Es Pisang Ijo Prikitiew", address: "Jl. Serpong Raya 56", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),]
    static var highestRatingMerchants: [Merchant] = [Merchant(id: UUID().uuidString, name: "Es Puter Linlin", address: "Jl. Serpong Raya 99", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),
                                                     Merchant(id: UUID().uuidString, name: "Es Slendang Mayang Sari", address: "Jl. Serpong Raya 11", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),
                                                     Merchant(id: UUID().uuidString, name: "Es Bahenol", address: "Jl. Serpong Raya 17", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),]
    
    static var searchResult: [Merchant] = [
        Merchant(id: UUID().uuidString, name: "Es goyang lidah", address: "Jl. Hayam Wuruk", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),
        Merchant(id: UUID().uuidString, name: "Es goyang gayung", address: "Jl. Hayam Wuruk", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),
        Merchant(id: UUID().uuidString, name: "Es goyang lihay", address: "Jl. Hayam Wuruk", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),
        Merchant(id: UUID().uuidString, name: "Es goyang ngebor", address: "Jl. Hayam Wuruk", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),
        Merchant(id: UUID().uuidString, name: "Es goyang asik", address: "Jl. Hayam Wuruk", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),
        Merchant(id: UUID().uuidString, name: "Es goyang yang", address: "Jl. Hayam Wuruk", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),
    ]
    
    static var highestRatingAllMerchants: [Merchant] = [
        Merchant(id: UUID().uuidString, name: "Es Puter Linlin", address: "Jl. Serpong Raya 99", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),
        Merchant(id: UUID().uuidString, name: "Es Slendang Mayang Sari", address: "Jl. Serpong Raya 11", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),
        Merchant(id: UUID().uuidString, name: "Es Bahenol", address: "Jl. Serpong Raya 17", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),
        Merchant(id: UUID().uuidString, name: "Es Puter Linlin", address: "Jl. Serpong Raya 99", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),
        Merchant(id: UUID().uuidString, name: "Es Slendang Mayang Sari", address: "Jl. Serpong Raya 11", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),
        Merchant(id: UUID().uuidString, name: "Es Bahenol", address: "Jl. Serpong Raya 17", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),
        Merchant(id: UUID().uuidString, name: "Es Puter Linlin", address: "Jl. Serpong Raya 99", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),
        Merchant(id: UUID().uuidString, name: "Es Slendang Mayang Sari", address: "Jl. Serpong Raya 11", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),
        Merchant(id: UUID().uuidString, name: "Es Bahenol", address: "Jl. Serpong Raya 17", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),
        Merchant(id: UUID().uuidString, name: "Es Puter Linlin", address: "Jl. Serpong Raya 99", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),
        Merchant(id: UUID().uuidString, name: "Es Slendang Mayang Sari", address: "Jl. Serpong Raya 11", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),
        Merchant(id: UUID().uuidString, name: "Es Bahenol", address: "Jl. Serpong Raya 17", lovedBy: [], menu: [], badges: [], phoneNumber: "000"),
    ]
    
    
    static let openingHoursField = "opening_hours"
    static let photosField = "photos"
    static let menuField = "menu"
    static let locationField = "location"
    static let lovedByField = "lovedBy"
    static let addressField = "address"
    static let nameField = "name"
    static let badgeField = "badges"
    static let phoneNumberField = "phone_number"
    
    var id: String
    var name: String
    var address: String
    var lovedBy: [String]
    var menu: [Menu]
    var badges: [Badge]
    var phoneNumber: String
    
}


//struct Badge: Hashable {
//    static var badgeDetails:[Badge] = [Badge(badgeName: "Great Taste", badgeImg:#imageLiteral(resourceName: "bigBadge2") , counts: 15),Badge(badgeName: "Clean Tools", badgeImg: #imageLiteral(resourceName: "bigBadge3"),counts: 10),Badge(badgeName: "Clean Ice", badgeImg: #imageLiteral(resourceName: "bigBadge1"),counts: 8)]
//
//    var badgeName: String
//    var badgeImg: UIImage?
//    var counts: Int?
//}

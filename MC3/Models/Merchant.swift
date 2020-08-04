//
//  Merchant.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 22/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import Foundation
import UIKit

struct Merchant: Hashable {
    
    static var trendingsDessert: [Merchant] = [Merchant(id: UUID().uuidString, name: "Es Doger", address: "Jl. Serpong Raya 1", lovedCount: 120,priceRange: "Rp 12.000 - Rp 20.000",menu: ["Es cendol","Es doger"],harga: ["Rp 12.000","13.000"],Badge: [#imageLiteral(resourceName: "bigBadge2"),#imageLiteral(resourceName: "bigBadge3"),#imageLiteral(resourceName: "bigBadge1")],photo: #imageLiteral(resourceName: "doger")),
                                              Merchant(id: UUID().uuidString, name: "Es Campur", address: "Jl. Serpong Raya 12", lovedCount: 75,priceRange: "Rp 12.000 - Rp 20.000",menu: ["Es cendol","Es doger"],harga: ["Rp 12.000","13.000"],Badge: [#imageLiteral(resourceName: "bigBadge2"),#imageLiteral(resourceName: "bigBadge3"),#imageLiteral(resourceName: "bigBadge1")],photo: #imageLiteral(resourceName: "doger")),
                                              Merchant(id: UUID().uuidString, name: "Es Goyobod", address: "Jl. Serpong Raya 3", lovedCount: 90,priceRange: "Rp 12.000 - Rp 20.000",menu: ["Es cendol","Es doger"],harga: ["Rp 12.000","13.000"],Badge: [#imageLiteral(resourceName: "bigBadge2"),#imageLiteral(resourceName: "bigBadge3"),#imageLiteral(resourceName: "bigBadge1")],photo: #imageLiteral(resourceName: "doger"))]
    static var nearbyMerchants: [Merchant] =  [Merchant(id: UUID().uuidString, name: "Es Cincau Mang Ucup", address: "Jl. Serpong Raya 10", lovedCount: 111,priceRange: "Rp 12.000 - Rp 20.000",menu: ["Es cendol","Es doger"],harga: ["Rp 12.000","13.000"],Badge: [#imageLiteral(resourceName: "bigBadge2"),#imageLiteral(resourceName: "bigBadge3"),#imageLiteral(resourceName: "bigBadge1")],photo: #imageLiteral(resourceName: "doger")),
                                                Merchant(id: UUID().uuidString, name: "Es Teler Uhuy", address: "Jl. Serpong Raya 13", lovedCount: 111,priceRange: "Rp 12.000 - Rp 20.000",menu: ["Es cendol","Es doger"],harga: ["Rp 12.000","13.000"],Badge: [#imageLiteral(resourceName: "bigBadge2"),#imageLiteral(resourceName: "bigBadge3"),#imageLiteral(resourceName: "bigBadge1")],photo: #imageLiteral(resourceName: "doger")),
                                                Merchant(id: UUID().uuidString, name: "Es Pisang Ijo Prikitiew", address: "Jl. Serpong Raya 56", lovedCount: 111,priceRange: "Rp 12.000 - Rp 20.000",menu: ["Es cendol","Es doger"],harga: ["Rp 12.000","13.000"],Badge: [#imageLiteral(resourceName: "bigBadge2"),#imageLiteral(resourceName: "bigBadge3"),#imageLiteral(resourceName: "bigBadge1")],photo: #imageLiteral(resourceName: "doger")),]
    static var highestRatingMerchants: [Merchant] = [Merchant(id: UUID().uuidString, name: "Es Puter Linlin", address: "Jl. Serpong Raya 99", lovedCount: 111,priceRange: "Rp 12.000 - Rp 20.000",menu: ["Es cendol","Es doger"],harga: ["Rp 12.000","13.000"],Badge: [#imageLiteral(resourceName: "bigBadge2"),#imageLiteral(resourceName: "bigBadge3"),#imageLiteral(resourceName: "bigBadge1")],photo: #imageLiteral(resourceName: "doger")),
                                                      Merchant(id: UUID().uuidString, name: "Es Slendang Mayang Sari", address: "Jl. Serpong Raya 11", lovedCount: 111,priceRange: "Rp 12.000 - Rp 20.000",menu: ["Es cendol","Es doger"],harga: ["Rp 12.000","13.000"],Badge: [#imageLiteral(resourceName: "bigBadge2"),#imageLiteral(resourceName: "bigBadge3"),#imageLiteral(resourceName: "bigBadge1")],photo: #imageLiteral(resourceName: "doger")),
                                                      Merchant(id: UUID().uuidString, name: "Es Bahenol", address: "Jl. Serpong Raya 17", lovedCount: 111,priceRange: "Rp 12.000 - Rp 20.000",menu: ["Es cendol","Es doger"],harga: ["Rp 12.000","13.000"],Badge: [#imageLiteral(resourceName: "bigBadge2"),#imageLiteral(resourceName: "bigBadge3"),#imageLiteral(resourceName: "bigBadge1")],photo: #imageLiteral(resourceName: "doger")),]
    
    static var searchResult: [Merchant] = [
        Merchant(id: UUID().uuidString, name: "Es goyang lidah", address: "Jl. Hayam Wuruk", lovedCount: 100,priceRange: "Rp 12.000 - Rp 20.000",menu: ["Es cendol","Es doger"],harga: ["Rp 12.000","13.000"],Badge: [#imageLiteral(resourceName: "bigBadge2"),#imageLiteral(resourceName: "bigBadge3"),#imageLiteral(resourceName: "bigBadge1")],photo: #imageLiteral(resourceName: "doger")),
        Merchant(id: UUID().uuidString, name: "Es goyang gayung", address: "Jl. Hayam Wuruk", lovedCount: 100,priceRange: "Rp 12.000 - Rp 20.000",menu: ["Es cendol","Es doger"],harga: ["Rp 12.000","13.000"],Badge: [#imageLiteral(resourceName: "bigBadge2"),#imageLiteral(resourceName: "bigBadge3"),#imageLiteral(resourceName: "bigBadge1")],photo: #imageLiteral(resourceName: "doger")),
        Merchant(id: UUID().uuidString, name: "Es goyang lihay", address: "Jl. Hayam Wuruk", lovedCount: 100,priceRange: "Rp 12.000 - Rp 20.000",menu: ["Es cendol","Es doger"],harga: ["Rp 12.000","13.000"],Badge: [#imageLiteral(resourceName: "bigBadge2"),#imageLiteral(resourceName: "bigBadge3"),#imageLiteral(resourceName: "bigBadge1")],photo: #imageLiteral(resourceName: "doger")),
        Merchant(id: UUID().uuidString, name: "Es goyang ngebor", address: "Jl. Hayam Wuruk", lovedCount: 100,priceRange: "Rp 12.000 - Rp 20.000",menu: ["Es cendol","Es doger"],harga: ["Rp 12.000","13.000"],Badge: [#imageLiteral(resourceName: "bigBadge2"),#imageLiteral(resourceName: "bigBadge3"),#imageLiteral(resourceName: "bigBadge1")],photo: #imageLiteral(resourceName: "doger")),
        Merchant(id: UUID().uuidString, name: "Es goyang asik", address: "Jl. Hayam Wuruk", lovedCount: 100,priceRange: "Rp 12.000 - Rp 20.000",menu: ["Es cendol","Es doger"],harga: ["Rp 12.000","13.000"],Badge: [#imageLiteral(resourceName: "bigBadge2"),#imageLiteral(resourceName: "bigBadge3"),#imageLiteral(resourceName: "bigBadge1")],photo: #imageLiteral(resourceName: "doger")),
        Merchant(id: UUID().uuidString, name: "Es goyang yang", address: "Jl. Hayam Wuruk", lovedCount: 100,priceRange: "Rp 12.000 - Rp 20.000",menu: ["Es cendol","Es doger"],harga: ["Rp 12.000","13.000"],Badge: [#imageLiteral(resourceName: "bigBadge2"),#imageLiteral(resourceName: "bigBadge3"),#imageLiteral(resourceName: "bigBadge1")],photo: #imageLiteral(resourceName: "doger")),
    ]
    
    
    
    var id: String
    var name: String
    var address: String
    var lovedCount: Int
    var priceRange: String
    var menu: [String] = []
    var harga: [String] = []
    var Badge: [UIImage?] = []
    var photo: UIImage?
}


//struct Badge: Hashable {
//    static var badgeDetails:[Badge] = [Badge(badgeName: "Great Taste", badgeImg:#imageLiteral(resourceName: "bigBadge2") , counts: 15),Badge(badgeName: "Clean Tools", badgeImg: #imageLiteral(resourceName: "bigBadge3"),counts: 10),Badge(badgeName: "Clean Ice", badgeImg: #imageLiteral(resourceName: "bigBadge1"),counts: 8)]
//
//    var badgeName: String
//    var badgeImg: UIImage?
//    var counts: Int?
//}

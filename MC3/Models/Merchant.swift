//
//  Merchant.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 22/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import Foundation

struct Merchant: Hashable {
    
    static var trendingsDessert: [Merchant] = [Merchant(id: UUID().uuidString, name: "Es Doger", address: "Jl. Serpong Raya 1", lovedCount: 120),
                                              Merchant(id: UUID().uuidString, name: "Es Campur", address: "Jl. Serpong Raya 12", lovedCount: 75),
                                              Merchant(id: UUID().uuidString, name: "Es Goyobod", address: "Jl. Serpong Raya 3", lovedCount: 90)]
    static var nearbyMerchants: [Merchant] =  [Merchant(id: UUID().uuidString, name: "Es Cincau Mang Ucup", address: "Jl. Serpong Raya 10", lovedCount: 111),
                                                Merchant(id: UUID().uuidString, name: "Es Teler Uhuy", address: "Jl. Serpong Raya 13", lovedCount: 111),
                                                Merchant(id: UUID().uuidString, name: "Es Pisang Ijo Prikitiew", address: "Jl. Serpong Raya 56", lovedCount: 111),]
    static var highestRatingMerchants: [Merchant] = [Merchant(id: UUID().uuidString, name: "Es Puter Linlin", address: "Jl. Serpong Raya 99", lovedCount: 111),
                                                      Merchant(id: UUID().uuidString, name: "Es Slendang Mayang Sari", address: "Jl. Serpong Raya 11", lovedCount: 111),
                                                      Merchant(id: UUID().uuidString, name: "Es Bahenol", address: "Jl. Serpong Raya 17", lovedCount: 111),]
    
    static var searchResult: [Merchant] = [
        Merchant(id: UUID().uuidString, name: "Es goyang lidah", address: "Jl. Hayam Wuruk", lovedCount: 100),
        Merchant(id: UUID().uuidString, name: "Es goyang gayung", address: "Jl. Hayam Wuruk", lovedCount: 100),
        Merchant(id: UUID().uuidString, name: "Es goyang lihay", address: "Jl. Hayam Wuruk", lovedCount: 100),
        Merchant(id: UUID().uuidString, name: "Es goyang ngebor", address: "Jl. Hayam Wuruk", lovedCount: 100),
        Merchant(id: UUID().uuidString, name: "Es goyang asik", address: "Jl. Hayam Wuruk", lovedCount: 100),
        Merchant(id: UUID().uuidString, name: "Es goyang yang", address: "Jl. Hayam Wuruk", lovedCount: 100),
    ]
    
    
    var id: String
    var name: String
    var address: String
    var lovedCount: Int
}

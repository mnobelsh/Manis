//
//  Menu.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 03/08/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import Foundation

struct Menu: Hashable {
    
    static let titleField = "title"
    static let priceField = "price"
    
    let uuid = UUID().uuidString
    let title: String
    let price: Double
}

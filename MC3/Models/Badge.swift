//
//  Badge.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 03/08/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import Foundation

enum BadgeType: Int {
    case greatTaste = 1, cleanTools = 2, cleanIngredients = 3
}

struct Badge: Hashable {
    
    static let typeField = "type"
    static let countField = "count"
    
    let uuid = UUID().uuidString
    var type: BadgeType
    var title: String
    var count: Int
    
    init(type: BadgeType, count: Int) {
        self.type = type
        self.count = count
        switch type {
            case .cleanIngredients:
                title = "Clean Ingredients"
            case .cleanTools:
                title = "Clean Tools"
            case .greatTaste:
                title = "Great Taste"
        }
    }
    
}

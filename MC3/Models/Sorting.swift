//
//  Sorting.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 27/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import Foundation

enum SortingType: Int {
    case rating = 0, taste = 1, lowestPrice = 2, hygiene = 3
}

struct Sorting: Hashable {
    
    static var types: [Sorting] = [Sorting(title: "Rating", type: .rating),
                                   Sorting(title: "Good Taste", type: .taste),
                                   Sorting(title: "Lowest Price", type: .lowestPrice),
                                   Sorting(title: "Hygiene", type: .hygiene)]
    
    let title: String
    let type: SortingType
    
}



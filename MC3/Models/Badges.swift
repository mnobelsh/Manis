//
//  Badges.swift
//  MC3
//
//  Created by Muhammad Thirafi on 05/08/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import Foundation
import UIKit

struct Badges {
    var title: String
    var badgeImg: UIImage
    var counts: String
    var photos: UIImage
    
    static var dataBagde: [Badges] = [Badges(title: "Great Taste", badgeImg: #imageLiteral(resourceName: "bigBadge2"),counts: "12",photos: #imageLiteral(resourceName: "doger")),
                                      Badges(title: "Clean Tools", badgeImg: #imageLiteral(resourceName: "bigBadge3"),counts: "10", photos: #imageLiteral(resourceName: "profile")),
                                      Badges(title: "Clean Ice", badgeImg: #imageLiteral(resourceName: "bigBadge1"),counts: "15", photos: #imageLiteral(resourceName: "doger"))]
    
}

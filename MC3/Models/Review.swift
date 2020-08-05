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
    
    static var reviewDetails: [Review] =
    [Review(id: UUID().uuidString, userName: "Bambang"),
     Review(id: UUID().uuidString, userName: "Nobal"),
     Review(id: UUID().uuidString, userName: "Sukma"),
     Review(id: UUID().uuidString, userName: "kamu"),
     Review(id: UUID().uuidString, userName: "I"),
     Review(id: UUID().uuidString, userName: "Hate"),
     Review(id: UUID().uuidString, userName: "U")]
    
    var id:String
    var userName:String
//    var rate: Double
//    var badge: UIImage?
//    var details:String?
}

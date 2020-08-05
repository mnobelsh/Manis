//
//  MerchantRoute.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 05/08/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import Foundation
import MapKit

struct MerchantRoute {
    let merchant: Merchant
    let origin: MKMapItem
    let destination: MKMapItem
    let route: MKRoute
    let estimatedTime: Double
}

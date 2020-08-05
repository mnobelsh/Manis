//
//  MerchantAnnotation.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 03/08/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import Foundation
import MapKit


class MerchantAnnotation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    static let identifier = "MerchantAnnotationIdentifier"
    var merchant: Merchant
    
    init(merchant: Merchant, coordinate: CLLocationCoordinate2D) {
        self.merchant =  merchant
        self.coordinate = coordinate
    }
    
    func updateCoordinate(newCoordinate coordinate: CLLocationCoordinate2D) {
        UIView.animate(withDuration: 0.25) {
            self.coordinate = coordinate
        }
    }
}

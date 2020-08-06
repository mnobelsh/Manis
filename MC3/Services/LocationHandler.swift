//
//  LocationHandler.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 29/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationHandlerDelegate {
    func locationUnauthorized()
}

class LocationHandler: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationHandler()
    var manager: CLLocationManager!
    var delegate: LocationHandlerDelegate?
    
    override init() {
        super.init()
        self.manager = CLLocationManager()
        self.manager.delegate = self
    }
    
    func requestLocation() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestAlwaysAuthorization()
            manager.startUpdatingLocation()
            
        case .denied,.restricted:
            delegate?.locationUnauthorized()
            
        case .notDetermined:
            manager.requestWhenInUseAuthorization()

        case .authorizedAlways:
            manager.startUpdatingLocation()
            
        @unknown default:
            print("RL : UNKNOWN")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestAlwaysAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("DEBUGS : \(error.localizedDescription)")
    }
    
    
}

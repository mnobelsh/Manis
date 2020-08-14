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
    func performFetch()
}

class LocationHandler: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationHandler()
    var manager: CLLocationManager!
    var delegate: LocationHandlerDelegate?
    
    static let testLocation = CLLocation(latitude: -6.24200439453125, longitude: 106.90338159547089)
    
    override init() {
        super.init()
        self.manager = CLLocationManager()
        self.manager.delegate = self
    }
    
    func requestLocation() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse,.authorizedAlways:
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestAlwaysAuthorization()
            manager.startUpdatingLocation()
            
        case .denied,.restricted:
            delegate?.locationUnauthorized()
            
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            
        @unknown default:
            print("RL : UNKNOWN")
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            delegate?.performFetch()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("DEBUGS : \(error.localizedDescription)")
    }
    
    
}

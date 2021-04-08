//
//  LocationManager.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 08.04.2021.
//  Copyright © 2021 Газияв Исхаков. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerProtocol {
    func requestUserLocation()
}

class LocationManager: LocationManagerProtocol {
    
    private let userLocationManager: CLLocationManager
    
    
    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.userLocationManager = locationManager
    }
    
    func requestUserLocation() {
        userLocationManager.requestLocation()
    }
}

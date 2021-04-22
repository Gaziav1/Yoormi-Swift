//
//  LocationManager.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 08.04.2021.
//  Copyright © 2021 Газияв Исхаков. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

protocol LocationManagerProtocol {
    func requestUserLocation()
    var locationChangeObservable: Observable<LocationItem?> { get }
}

struct LocationItem {
    let locationString: String
    let location: CLLocation?
}

class LocationManager: NSObject, LocationManagerProtocol {
    
    
    private let userLocationManager: CLLocationManager
    private let geocoder: CLGeocoder
    private var currentLocationSubject = PublishSubject<LocationItem?>()
    
    var locationChangeObservable: Observable<LocationItem?> {
        return currentLocationSubject.asObservable()
    }
    
    init(locationManager: CLLocationManager = CLLocationManager(),
         geocoder: CLGeocoder = CLGeocoder()) {
        self.userLocationManager = locationManager
        self.geocoder = geocoder
        super.init()
        userLocationManager.delegate = self
    }
    
    func requestUserLocation() {
       
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            userLocationManager.requestLocation()
        case .notDetermined:
            userLocationManager.requestWhenInUseAuthorization()
        default:
            currentLocationSubject.onNext(nil)
        }
    }
}


extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            userLocationManager.requestLocation()
        default:
            ()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        
        geocoder.reverseGeocodeLocation(currentLocation) { [weak self] (placemarks, error) in
        
            guard let placemark = placemarks?.first, let addressString = placemark.compactAddress else {
                self?.currentLocationSubject.onNext(nil)
                return
            }
            
            let locationItem = LocationItem(locationString: addressString, location: currentLocation)
            self?.currentLocationSubject.onNext(locationItem)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.currentLocationSubject.onNext(nil)
    }
}


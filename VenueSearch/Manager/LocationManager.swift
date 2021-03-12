//
//  LocationManager.swift
//  VenueSearch
//
//  Created by Ajay Sharma on 11/03/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerInterface {
    var locationServiceDelegate: LocationServiceDelegate? { get set }
    var desiredAccuracy: CLLocationAccuracy { get set }
    var distanceFilter: CLLocationDistance { get set }
    
    func requestWhenInUseAuthorization()
    func startUpdatingLocation()
    func stopUpdatingLocation()
}

extension LocationManagerInterface {
    func requestWhenInUseAuthorization() {}
    func stopUpdatingLocation() {}
}

protocol LocationServiceDelegate: class {
    func locationManager(_ manager: LocationManagerInterface, didUpdateLocations locations: [CLLocation])
    func locationManager(_ manager: LocationManagerInterface, didChangeAuthorization status: CLAuthorizationStatus)
}

class LocationService: NSObject {
    
    var locationManager: LocationManagerInterface
    private var currentLocationCallback: ((CLLocation) -> Void)?

    init(locationManager: LocationManagerInterface = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 5.0
        self.locationManager.locationServiceDelegate = self
    }
    
    func getCurrentLocation(completion: @escaping (CLLocation) -> Void) {
        currentLocationCallback = {  (location) in
            completion(location)
        }
        self.locationManager.stopUpdatingLocation()
        self.locationManager.startUpdatingLocation()
        self.locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.currentLocationCallback?(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
}

extension LocationService: LocationServiceDelegate {
    
    func locationManager(_ manager: LocationManagerInterface, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.currentLocationCallback?(location)
    }
    
    func locationManager(_ manager: LocationManagerInterface, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}

extension CLLocationManager: LocationManagerInterface {
    var locationServiceDelegate: LocationServiceDelegate? {
        get { return delegate as! LocationServiceDelegate? }
        set { delegate = newValue as! CLLocationManagerDelegate? }
    }
}

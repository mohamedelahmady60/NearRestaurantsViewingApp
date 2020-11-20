//
//  LocationService.swift
//  RestaurantViewingApp
//
//  Created by Mo Elahmady on 11/14/20.
//  Copyright © 2020 Mo Elahmady. All rights reserved.
//

import Foundation
import CoreLocation

enum Result<Type> {
    case success(Type)
    case failure(Error)
}

final class LocationService: NSObject {
 
    //MARK: - Properties
    private let locationManager: CLLocationManager
    var authorizationStatus: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }

    
    init(locationManager: CLLocationManager = .init()) {
        self.locationManager = locationManager
        //init the NSObject
        super.init()
        //set the delegate to self
        self.locationManager.delegate = self
    }
    
    
    //MARK: - closures
    var didGetResponse: ((Result<CLLocation>) -> Void)?
    var didChangeStatus: ((Bool) -> Void)?
    
    
    
    //MARK: - Functions
    //ask the user to use the mobile location
    func requestLocationAuthorization() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    //start getting the location
    func getLocation() {
        self.locationManager.requestLocation()
    }

}//end of class



extension LocationService: CLLocationManagerDelegate {
    
    // if failed to get location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // return the error
        self.didGetResponse?(.failure(error))
    }

    
    // if updated location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // return the location
        if let location = locations.last {
            self.didGetResponse?(.success(location))
        }
    }
    
    
    // if authorization status changed
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //return the status
        switch status {
        case .notDetermined, .restricted, .denied:
            self.didChangeStatus?(false)
        default:
            self.didChangeStatus?(true)
        }
    
    }

    
}//end of extension

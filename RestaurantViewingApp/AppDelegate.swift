//
//  AppDelegate.swift
//  RestaurantViewingApp
//
//  Created by Mo Elahmady on 11/11/20.
//  Copyright © 2020 Mo Elahmady. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //initialize a window
    let window = UIWindow()
    
    //initialize an object from LocationService
    let locationService = LocationService()
    
    //initialize an object from the our main storyboard
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        //check the current authorization status
        switch locationService.authorizationStatus {
        case .notDetermined, .denied, .restricted:
                        
            // go to the permission view controller to ask about the permission
            let locationPermissionViewController = storyboard.instantiateViewController(identifier: "LocationPermissionViewController") as? LocationPermissionViewController
            
            locationPermissionViewController?.locationService = self.locationService
            window.rootViewController = locationPermissionViewController
            
        default:
             //               let restaurantListTableViewController = storyboard.instantiateViewController(identifier: "RestaurantsListTableViewController") as? RestaurantsListTableViewController
            //
            //                window.rootViewController = restaurantListTableViewController
            
            assertionFailure()
            
        }
        
        
        window.makeKeyAndVisible()
        
        return true
    }
    
    
}


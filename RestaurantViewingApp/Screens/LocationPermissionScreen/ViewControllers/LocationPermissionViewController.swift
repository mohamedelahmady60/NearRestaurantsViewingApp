//
//  LocationPermissionViewController.swift
//  RestaurantViewingApp
//
//  Created by Mo Elahmady on 11/14/20.
//  Copyright © 2020 Mo Elahmady. All rights reserved.
//

import UIKit

class LocationPermissionViewController: UIViewController {
 
    //MARK: - Outlet
    @IBOutlet weak var locationPermissionView: LocationPermissionView!
    
    //MARK: - variables
    var locationService: LocationService?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // request the authorization to the location from the user when he press allow button
        locationPermissionView.didTapAllow = { [weak self] in
            self?.locationService?.requestLocationAuthorization()
        }
        
        //when the authorization Status change
        locationService?.didChangeStatus = { [weak self] status in
            if status {
                //start getting the location
                self?.locationService?.getLocation()
            }
        }
        
        //when we get a response from the core location
        locationService?.didGetResponse = { [weak self] response in
            
            switch response {
            case .failure(let error):
                assertionFailure("Error getting the location \(error)")
            case .success(let location):
                print(location.coordinate.latitude)
                print(location.coordinate.longitude)

                
            }
            
        }
        // Do any additional setup after loading the view.
    }
    

}

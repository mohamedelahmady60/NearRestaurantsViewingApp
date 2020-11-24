//
//  LocationPermissionViewController.swift
//  RestaurantViewingApp
//
//  Created by Mo Elahmady on 11/14/20.
//  Copyright © 2020 Mo Elahmady. All rights reserved.
//

import UIKit


protocol LocationPermissionViewControllerDelegate: class {
    func didTapAllow()
}

class LocationPermissionViewController: UIViewController {
 
    //MARK: - Outlet
    @IBOutlet weak var locationPermissionView: LocationPermissionView!
    
    //MARK: - variables
    weak var delegate: LocationPermissionViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // request the authorization to the location from the user when he press allow button
        locationPermissionView.didTapAllow = {
            self.delegate?.didTapAllow()
        }
        
        // Do any additional setup after loading the view.
    }
    

}

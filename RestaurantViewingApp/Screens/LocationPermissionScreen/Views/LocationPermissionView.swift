//
//  LocationPermissionViewController.swift
//  RestaurantViewingApp
//
//  Created by Mo Elahmady on 11/14/20.
//  Copyright © 2020 Mo Elahmady. All rights reserved.
//

import UIKit

@IBDesignable class LocationPermissionView: BaseView {

    //MARK: - Outlets
    
    @IBOutlet weak var allowButton: UIButton!
    @IBOutlet weak var denyButton: UIButton!

    //MARK: - Closure
    var didTapAllow: (() -> Void)?
    
    
    //MARK: - Actions
    
    @IBAction func allowButtonPressed (_ sender: UIButton) {
        //call the closure 
        didTapAllow?()
    }
    
    @IBAction func denyButtonPressed (_ sender: UIButton) {
        
    }
}

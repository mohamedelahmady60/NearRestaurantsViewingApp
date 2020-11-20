//
//  DetailsFoodView.swift
//  RestaurantViewingApp
//
//  Created by Mo Elahmady on 11/14/20.
//  Copyright © 2020 Mo Elahmady. All rights reserved.
//

import UIKit
import MapKit

@IBDesignable class DetailsFoodView: BaseView {
    
    //MARK: - Outlets
    
    //collection view
    @IBOutlet weak var collectionView: UICollectionView!
   //page control
    @IBOutlet weak var pageControl: UIPageControl!

    //labels
    @IBOutlet weak var pricLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!

    //map view
    @IBOutlet weak var mapView: MKMapView!
    
    
    //MARK: - Actions
    
    //page control action
    @IBAction func pageControlPressed(_ sender:UIPageControl) {
        
    }
        

    
    
}


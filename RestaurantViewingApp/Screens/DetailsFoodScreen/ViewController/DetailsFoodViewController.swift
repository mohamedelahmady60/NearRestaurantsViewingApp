//
//  DetailsFoodViewController.swift
//  RestaurantViewingApp
//
//  Created by Mo Elahmady on 11/14/20.
//  Copyright © 2020 Mo Elahmady. All rights reserved.
//

import UIKit
import AlamofireImage
import CoreLocation
import MapKit


class DetailsFoodViewController: UIViewController {

    // IBoutlet from our view
    @IBOutlet weak var detailsFoodView: DetailsFoodView?
    
    // resturant Details that comes out from the app delegate
    var restaurantDetailsViewDataModel: RestaurantDetailsViewDataModel? {
        didSet {
            updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailsFoodView?.collectionView?.register(DetailsCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        
        detailsFoodView?.collectionView?.dataSource = self
        detailsFoodView?.collectionView?.delegate = self
    }
    

    func updateView() {
        if let restaurantDetailsData = self.restaurantDetailsViewDataModel {
            detailsFoodView?.pricLabel?.text = restaurantDetailsData.price
            detailsFoodView?.hoursLabel?.text = restaurantDetailsData.isOpen
            detailsFoodView?.locationLabel?.text = restaurantDetailsData.phoneNumber
            detailsFoodView?.ratingsLabel?.text = restaurantDetailsData.rating
            detailsFoodView?.collectionView?.reloadData()
            centerMap(for: restaurantDetailsData.coordinate)
            title = restaurantDetailsData.name
        }
    }
    
    func centerMap(for coordinates: CLLocationCoordinate2D ) {
        let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 100, longitudinalMeters: 100)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        detailsFoodView?.mapView?.addAnnotation(annotation)
        detailsFoodView?.mapView?.setRegion(region, animated: true)
    }
    
}


//MARK: - Collection View data source Methods
extension DetailsFoodViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantDetailsViewDataModel?.imageUrls.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! DetailsCollectionViewCell
        
        if let imageUrl = restaurantDetailsViewDataModel?.imageUrls[indexPath.item] {
            cell.imageView.af.setImage(withURL: imageUrl)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    
    
}



//MARK: - Collection View delegate Methods
extension DetailsFoodViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
     
        detailsFoodView?.pageControl?.currentPage = indexPath.item
    }
}

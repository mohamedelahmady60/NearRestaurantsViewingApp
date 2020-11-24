//
//  AppDelegate.swift
//  RestaurantViewingApp
//
//  Created by Mo Elahmady on 11/11/20.
//  Copyright © 2020 Mo Elahmady. All rights reserved.
//

import UIKit
import Moya
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: - Objects
    
    //initialize a window
    let window = UIWindow()
    
    //initialize an object from LocationService
    let locationService = LocationService()
    
    //initialize an object from the our main storyboard
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    //to test our Network service
    let service = MoyaProvider<YelpService>()
    
    //to decode the JSON data to Swift data
    let JsonDecoder = JSONDecoder()
    
    
    
    
    //MARK: - Functions
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        //when the authorization Status change
        locationService.didChangeStatus = { [weak self] status in
            if status {
                //start getting the location
                self?.locationService.getLocation()
            }
        }
        
        //when we get a response from the core location
        locationService.didGetResponse = { [weak self] response in
            
            switch response {
            case .failure(let error):
                assertionFailure("Error getting the location \(error)")
            case .success(let location):
                self?.loadBusinesses(with: location.coordinate)
                
            }
            
        }
        
        
        
        //choose the initial view
        self.goToSuitableInitialView()
        
        return true
    }
    
    
    private func loadBusinesses(with coordinates: CLLocationCoordinate2D) {
        
        //to convert from SnakeCase (Python) to camelCase (Swift)
        JsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        //request URL to get the data
        service.request(.search(latitude: coordinates.latitude, longtide: coordinates.longitude)) { [weak self](result) in
            switch result {
            case .success(let response):
                do {
                    guard let strongSelf = self else { return }
                    // decode the JSON data
                    let businessesDecodedData = try strongSelf.JsonDecoder.decode(BusinessesDecodedData.self, from: response.data)
                    // define the array of cells
                    let resturantListTableViewTotalCellsDataModel = businessesDecodedData.businesses.compactMap(ResturantListTableViewCellDataModel.init)
                        .sorted { ($0.distance < $1.distance )}
                    // jump to the RestuarantsListTableViewController to view the resturants
                    if let navigationController = strongSelf.window.rootViewController as? UINavigationController {
                        
                        print("Hello1")
                        
                        if let restuarantsListTableViewController = navigationController.topViewController as? RestaurantsListTableViewController {
                            
                            
                            print("Hello2")
                            
                            restuarantsListTableViewController.resturantListTableViewTotalCellsDataModel = resturantListTableViewTotalCellsDataModel
                        }
                    }
                } catch {
                    print("Error Decoding Data \(error)")
                }
            case .failure(let error):
                print("error Getting Response \(error)")
            }
        }
        
        
    }
    
    private func goToSuitableInitialView() {
        //check the current authorization status
        switch locationService.authorizationStatus {
        case .notDetermined, .denied, .restricted:
            // go to the permission view controller to ask about the permission
            let locationPermissionViewController = storyboard
                .instantiateViewController(identifier: "LocationPermissionViewController") as? LocationPermissionViewController
            //locationPermissionViewController?.delegate = self
            window.rootViewController = locationPermissionViewController
            
        default:
            // go to the RestuarantsListTableViewController (the top view of the navigation Controller)
            let navigationController = storyboard
                .instantiateViewController(identifier: "RestaurantNavigationController") as? UINavigationController
            window.rootViewController = navigationController
            //locationService.getLocation()
        }
        window.makeKeyAndVisible()
    }
    
}


extension AppDelegate: LocationPermissionViewControllerDelegate {
    
    //when the user presses allow we will request the authorization
    func didTapAllow() {
        locationService.requestLocationAuthorization()
    }
    
    
}


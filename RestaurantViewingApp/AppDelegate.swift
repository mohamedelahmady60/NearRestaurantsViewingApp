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
    
    let restaurantsListTableViewController = RestaurantsListTableViewController()
    
    var navigationControllerHolder: UINavigationController?
    
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
        
        restaurantsListTableViewController.delegate = self
        
        //MARK: - choose the initial view
        self.goToSuitableInitialView()
        
        return true
    }
    
    
    
    //MARK: - this function used to load the restaurants
    private func loadBusinesses(with coordinates: CLLocationCoordinate2D) {
        
        //to convert from SnakeCase (Python) to camelCase (Swift)
        JsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        //request URL to get the data
        service.request(.search(latitude: coordinates.latitude, longtide: coordinates.longitude)) { [weak self](result) in
            
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let response):
                do {
                    // decode the JSON data
                    let businessesDecodedData = try strongSelf.JsonDecoder.decode(BusinessesDecodedData.self, from: response.data)
                    // define the array of cells
                    let resturantListTableViewTotalCellsDataModel = businessesDecodedData.businesses.compactMap(RestaurantListTableViewCellDataModel.init)
                        .sorted { ($0.distance < $1.distance )}
                    
                    if let navigationController = strongSelf.window.rootViewController as? UINavigationController,
                        let restaurantsListTableViewController = navigationController.topViewController as? RestaurantsListTableViewController {
                        restaurantsListTableViewController.restaurantListTableViewTotalCellsDataModel = resturantListTableViewTotalCellsDataModel ?? []
                    } else if let navigationController = strongSelf.storyboard
                        .instantiateViewController(identifier: "RestaurantNavigationController") as? UINavigationController {
                        strongSelf.navigationControllerHolder = navigationController
                        strongSelf.window.rootViewController?.present(navigationController, animated: true, completion: {
                            (navigationController.topViewController as? RestaurantsListTableViewController)?.delegate = self
                            (navigationController.topViewController as? RestaurantsListTableViewController)?.restaurantListTableViewTotalCellsDataModel = resturantListTableViewTotalCellsDataModel ?? []

                        })
                    }
                    
                    
                } catch {
                    print("error decoding data \(error)")
                }
            case .failure(let error):
                print("error Getting Response \(error)")
            }
        }
    }
    
    
    //MARK: - this function is used to do to the suitable initial view
    private func goToSuitableInitialView() {
        //check the current authorization status
        switch locationService.authorizationStatus {
        case .notDetermined, .denied, .restricted:
            // go to the permission view controller to ask about the permission
            let locationPermissionViewController = storyboard
                .instantiateViewController(identifier: "LocationPermissionViewController") as? LocationPermissionViewController
            locationPermissionViewController?.delegate = self
            window.rootViewController = locationPermissionViewController
            
        default:
            // go to the RestuarantsListTableViewController (the top view of the navigation Controller)
            let navigationController = storyboard
                .instantiateViewController(identifier: "RestaurantNavigationController") as? UINavigationController
            self.navigationControllerHolder = navigationController
            window.rootViewController = navigationController
            locationService.getLocation()
            (navigationController?.topViewController as? RestaurantsListTableViewController)?.delegate = self
        }
        window.makeKeyAndVisible()
    }
    
    
    //MARK: - this function is used to load restaurant details
    private func loadRestaurantDetails(for viewController: UIViewController, withID id: String) {
        
        JsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        service.request(.details(id: id)) { [weak self ] (result) in
            switch result {
            case .success(let response):
                guard let strongSelf = self else { return }
                do {
                    // decode the JSON data
                    let resturantDetails = try strongSelf.JsonDecoder.decode(ResturantDetails.self, from: response.data)
                    let restaurantDetailsViewDataModel = RestaurantDetailsViewDataModel(resturantDetails: resturantDetails)
                    (viewController as? RestaurantDetailsViewController)?.restaurantDetailsViewDataModel = restaurantDetailsViewDataModel
                }catch {print("Error decoding data\(error)")}
                
            case .failure(let error):
                print ("Failed to get data\(error)")
            }
        }
    }
    
}



//MARK: - LocationPermissionViewControllerDelegate
extension AppDelegate: LocationPermissionViewControllerDelegate {
    
    //when the user presses allow we will request the authorization
    func didTapAllow() {
        locationService.requestLocationAuthorization()
    }    
}


//MARK: - RestaurantsListTableViewControllerDelegate
extension AppDelegate: RestaurantsListTableViewControllerDelegate{
    
    func didTapCell(_ viewController: UIViewController, viewModel: RestaurantListTableViewCellDataModel) {
        loadRestaurantDetails(for: viewController, withID: viewModel.id)
    }
}

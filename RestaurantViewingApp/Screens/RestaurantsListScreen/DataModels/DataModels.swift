//
//  DataModels.swift
//  RestaurantViewingApp
//
//  Created by Mo Elahmady on 11/21/20.
//  Copyright © 2020 Mo Elahmady. All rights reserved.
//

import Foundation
import CoreLocation

//MARK: - decoded JSON data
struct BusinessesDecodedData: Codable {
    let businesses: [Business]
}

struct Business: Codable {
    let id: String
    let name: String
    let imageUrl: URL
    let distance: Double
}


//MARK: - Restaurant List Table View Cell Data
struct RestaurantListTableViewCellDataModel {
    let id: String
    let name: String
    let imageUrl: URL
    let distance: Double
    
    static var numberFormatter: NumberFormatter {
        let numFormatter = NumberFormatter()
        numFormatter.numberStyle = .decimal
        numFormatter.maximumFractionDigits = 2
        numFormatter.minimumFractionDigits = 2
        return numFormatter
    }
    
    var formattedDistance: String? {
        return RestaurantListTableViewCellDataModel.numberFormatter.string(from: distance as NSNumber)
    }
    
    init(business: Business) {
        self.id = business.id
        self.name = business.name
        self.imageUrl = business.imageUrl
        self.distance = business.distance / 1609.344
    }

}


struct ResturantDetails: Decodable {
    let price: String
    let phone: String 
    let isClosed: Bool
    let rating: Double
    let name: String
    let photos: [URL]
    let coordinates: CLLocationCoordinate2D
}

extension CLLocationCoordinate2D: Decodable {
    enum CodingKeys: CodingKey {
        case latitude
        case longitude
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        self.init(latitude: latitude, longitude: longitude)
    }
}


//MARK: - Restaurant Details View Data
struct RestaurantDetailsViewDataModel {
    let name: String
    let price: String
    let isOpen: String
    let phoneNumber: String
    let rating: String
    let imageUrls: [URL]
    let coordinate: CLLocationCoordinate2D
    
    init(resturantDetails: ResturantDetails) {
        self.name = resturantDetails.name
        self.price = resturantDetails.price
        self.isOpen = resturantDetails.isClosed ? "Closed" : "Open"
        self.phoneNumber = resturantDetails.phone
        self.rating = "\(resturantDetails.rating) / 5.0"
        self.imageUrls = resturantDetails.photos
        self.coordinate = resturantDetails.coordinates
    }
}


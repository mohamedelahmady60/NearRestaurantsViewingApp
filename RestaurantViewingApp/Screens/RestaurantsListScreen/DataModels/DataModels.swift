//
//  DataModels.swift
//  RestaurantViewingApp
//
//  Created by Mo Elahmady on 11/21/20.
//  Copyright © 2020 Mo Elahmady. All rights reserved.
//

import Foundation


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


//MARK: - Resturant List Table View Cell Data
struct ResturantListTableViewCellDataModel {
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
        return ResturantListTableViewCellDataModel.numberFormatter.string(from: distance as NSNumber)
    }
    
    init(business: Business) {
        self.id = business.id
        self.name = business.name
        self.imageUrl = business.imageUrl
        self.distance = business.distance / 1609.344
    }

}

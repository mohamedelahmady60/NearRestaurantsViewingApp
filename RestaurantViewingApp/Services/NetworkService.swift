//
//  NetworkService.swift
//  RestaurantViewingApp
//
//  Created by Mo Elahmady on 11/20/20.
//  Copyright © 2020 Mo Elahmady. All rights reserved.
//

import Foundation
import Moya

private let apiKey = "-3lhI-7RmyUM552rWkNrnY_T7aZe_BBtdtCIc34kSNP8-jATcuKncIGeGTPSZfV1-KlsEC40pjTg2gNIw8WY3nQ_0No4v9A_DWHg4WH9TB_vTlRm2O3nhbKICnK3X3Yx"

enum YelpService :TargetType {
    
    case search(latitude: Double, longtide: Double)
    case details(id: String)
    
    var baseURL: URL {
        return URL(string: "https://api.yelp.com/v3/businesses")!
    }
    
    var path: String {
        switch self {
        case .search:
            return "/search"
        case .details(id: let id):
            return "\(id)"

        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .search(let latitude, let longtide):
            return .requestParameters(
                parameters: ["latitude": latitude, "longitude": longtide, "limit": 25],
                encoding: URLEncoding.queryString)
        case .details:
            return .requestPlain

        }
    }
    
    var headers: [String : String]? {
        return ["Authorization": "Bearer \(apiKey)"]
    }
    
    
}

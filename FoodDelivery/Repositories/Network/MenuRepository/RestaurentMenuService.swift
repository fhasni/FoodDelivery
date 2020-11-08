//
//  YelpBusinessesProvider.swift
//  FoodDelivery
//
//  Created by fhasni on 10/24/20.
//  Copyright © 2020 fhasni. All rights reserved.
//

import Foundation
import Moya

enum RestaurentMenuService {
    case getMenu(restaurentId: String)
}

extension RestaurentMenuService: TargetType {
    var baseURL: URL {
        return URL(string: "https://FOOD_DELIVERY_BASE_URL")!
    }
    
    var path: String {
        switch self {
        case .getMenu(let restaurentId):
            return "/menue/\(restaurentId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMenu:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getMenu:
            if let path = Bundle.main.path(forResource: "menu", ofType:"json") {
                let url = URL(fileURLWithPath: path)
                do {
                    let data = try Data(contentsOf: url)
                    print("DEBUG: mock data loaded successfully")
                    return data
                } catch {
                    print("DEBUG: failed to load mock data")
                    return Data()
                }
            } else {
                print("DEBUG: failed to load mock data")
                return Data()
            }
        }
    }
    
    var task: Task {
        switch self {
        case .getMenu:
            let parameters: [String : Any] =  [:]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
}

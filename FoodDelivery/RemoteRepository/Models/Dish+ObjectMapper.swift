//
//  Dish+ObjectMapper.swift
//  FoodDelivery
//
//  Created by fhasni on 11/1/20.
//  Copyright © 2020 fhasni. All rights reserved.
//

import Foundation

import ObjectMapper

extension Dish: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id              <- map["id"]
        name            <- map["name"]
        image           <- map["image"]
        description     <- map["description"]
    }
}

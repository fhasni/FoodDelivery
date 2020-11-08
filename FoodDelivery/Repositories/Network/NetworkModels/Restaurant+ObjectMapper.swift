//
//  Restaurant+Mappable.swift
//  FoodDelivery
//
//  Created by fhasni on 10/25/20.
//  Copyright © 2020 fhasni. All rights reserved.
//

import ObjectMapper

extension Menu: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        image       <- map["image"]
        categories        <- map["menu"]
    }
}




//
//  CartItem.swift
//  FoodDelivery
//
//  Created by fhasni on 11/15/20.
//  Copyright © 2020 fhasni. All rights reserved.
//

import Foundation

struct CartItem {
    var id : String {
        return dish.id
    }
    var dish: Dish!
    
    var count: Int!
    
}

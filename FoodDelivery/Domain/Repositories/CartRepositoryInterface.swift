//
//  CartRepositoryInterface.swift
//  FoodDelivery
//
//  Created by fhasni on 11/8/20.
//  Copyright © 2020 fhasni. All rights reserved.
//

import Foundation

protocol CartRepositoryInterface {
    func addToCart(dish: Dish)
    func removeFromCart(dish: Dish)
}

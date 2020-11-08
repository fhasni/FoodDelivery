//
//  MemCartRepository.swift
//  FoodDelivery
//
//  Created by fhasni on 11/8/20.
//  Copyright © 2020 fhasni. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

struct MemCart {
    static let shared = MemCart()
    let dishes: BehaviorRelay<[Dish]> = BehaviorRelay(value: [])
}


struct MemCartRepository : CartRepositoryInterface {
    
    func addToCart(dish: Dish) {
        MemCart.shared.dishes.accept(MemCart.shared.dishes.value + [dish])
    }
    
    func removeFromCart(dish: Dish) {
        let dishes = MemCart.shared.dishes.value.filter { currentdish in
            currentdish.id != dish.id
        }
        
        MemCart.shared.dishes.accept(dishes)
    }
    
}

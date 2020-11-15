//
//  CartRepositoryInterface.swift
//  FoodDelivery
//
//  Created by fhasni on 11/8/20.
//  Copyright © 2020 fhasni. All rights reserved.
//

import RxSwift
import RxRelay

protocol CartRepositoryInterface {
    func add(dish: Dish)
    func remove(dish: Dish)
    func getItems() -> BehaviorRelay<[Dish]>
}

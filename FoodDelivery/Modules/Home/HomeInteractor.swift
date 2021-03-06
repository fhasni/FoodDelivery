//
//  HomeInteractor.swift
//  FoodDelivery
//
//  Created by fhasni on 10/29/20.
//  Copyright (c) 2020 fhasni. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation
import RxSwift

final class HomeInteractor {
    private let menuRepositoty: MenuRepositoryInterface
    private let cartRepositoty: CartRepositoryInterface

    init(menuRepository: MenuRepositoryInterface, cartRepositoty: CartRepositoryInterface) {
        self.menuRepositoty = menuRepository
        self.cartRepositoty = cartRepositoty
    }
}

// MARK: - Extensions -

extension HomeInteractor: HomeInteractorInterface {

    func getMenu() -> Single<Menu> {
        return menuRepositoty.getMenu(restaurentId: "qwerty")
    }
    
    func addToCart(dish: Dish) {
        return cartRepositoty.add(dish: dish)
    }
    
    func removeFromCart(dish: Dish) {
        return cartRepositoty.remove(dish: dish)
    }
    
    func getCartItems() -> Observable<[Dish]> {
        return cartRepositoty.getItems().asObservable()
    }
    
}

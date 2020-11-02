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
    let repositoty: RepositoryInterface
    
    init(repositoty: RepositoryInterface) {
        self.repositoty = repositoty
    }
}

// MARK: - Extensions -

extension HomeInteractor: HomeInteractorInterface {
    var menu: Single<Menu?> {
        return repositoty.search(latitude: 37.786882, longitude: -122.399972)
    }
    
}

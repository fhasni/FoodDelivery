//
//  Repository.swift
//  FoodDelivery
//
//  Created by fhasni on 10/31/20.
//  Copyright © 2020 fhasni. All rights reserved.
//

import RxSwift

protocol MenuRepositoryInterface {
    func getMenu(restaurentId: String) -> Single<Menu>
}

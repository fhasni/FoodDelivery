//
//  StubRepository.swift
//  FoodDelivery
//
//  Created by fhasni on 10/25/20.
//  Copyright © 2020 fhasni. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Moya_ObjectMapper

struct StubRepository : RepositoryInterface {
    let provider = MoyaProvider<RestaurentMenuService>(stubClosure: MoyaProvider.immediatelyStub)

    func search(latitude: Double, longitude: Double) -> Single<Menu?> {
        return provider.rx.request(.getMenu)
            .mapObject(Menu.self)
            .map{ $0 }
    }
}



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

struct StubMenuRepository : MenuRepositoryInterface {
    private let provider = MoyaProvider<RestaurentMenuService>(stubClosure: MoyaProvider.immediatelyStub)

    func getMenu(restaurentId: String) -> Single<Menu> {
        return provider.rx.request(.getMenu(restaurentId: restaurentId))
            .mapObject(Menu.self)
            .map{ $0 }
    }
}



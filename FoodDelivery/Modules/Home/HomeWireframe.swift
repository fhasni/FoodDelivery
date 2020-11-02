//
//  HomeWireframe.swift
//  FoodDelivery
//
//  Created by fhasni on 10/29/20.
//  Copyright (c) 2020 fhasni. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import RxSwift
import RxCocoa

final class HomeWireframe: BaseWireframe {

    // MARK: - Private properties -

    private let storyboard = UIStoryboard(name: "Home", bundle: nil)

    // MARK: - Module setup -

    init() {
        let moduleViewController = storyboard.instantiateViewController(ofType: HomeViewController.self)
        super.init(viewController: moduleViewController)

        let formatter = HomeFormatter()
        let interactor = HomeInteractor(repositoty: StubRepository())
        let presenter = HomePresenter(view: moduleViewController, formatter: formatter, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension HomeWireframe: HomeWireframeInterface {
}

//
//  HomeViewController.swift
//  FoodDelivery
//
//  Created by fhasni on 10/24/20.
//  Copyright (c) 2020 fhasni. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {

    // MARK: - Public properties -

    var presenter: HomePresenterInterface!
    @IBOutlet weak var homeLabel: UILabel!
    
    // MARK: - Private properties -

    private let disposeBag = DisposeBag()

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

// MARK: - Extensions -

extension HomeViewController: HomeViewInterface {
}

private extension HomeViewController {

    func setupView() {
        let output = Home.ViewOutput()

        let input = presenter.configure(with: output)
        
        homeLabel.text = "Hello VIPER"
        navigationItem.title = "Home"
    }

}

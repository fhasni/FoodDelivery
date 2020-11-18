//
//  DishDetailInterfaces.swift
//  FoodDelivery
//
//  Created by fhasni on 11/18/20.
//  Copyright (c) 2020 fhasni. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import RxSwift
import RxCocoa

protocol DishDetailWireframeInterface: WireframeInterface {
}

protocol DishDetailViewInterface: ViewInterface {
}

protocol DishDetailPresenterInterface: PresenterInterface {
    func configure(with output: DishDetail.ViewOutput) -> DishDetail.ViewInput
}

protocol DishDetailFormatterInterface: FormatterInterface {
    func format(for input: DishDetail.FormatterInput) -> DishDetail.FormatterOutput
}

protocol DishDetailInteractorInterface: InteractorInterface {
}

enum DishDetail {

    struct ViewOutput {
    }

    struct ViewInput {
        let models: FormatterOutput
    }

    struct FormatterInput {
    }

    struct FormatterOutput {
    }

}
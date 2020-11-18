//
//  CheckoutInterfaces.swift
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

protocol CheckoutWireframeInterface: WireframeInterface {
}

protocol CheckoutViewInterface: ViewInterface {
}

protocol CheckoutPresenterInterface: PresenterInterface {
    func configure(with output: Checkout.ViewOutput) -> Checkout.ViewInput
}

protocol CheckoutFormatterInterface: FormatterInterface {
    func format(for input: Checkout.FormatterInput) -> Checkout.FormatterOutput
}

protocol CheckoutInteractorInterface: InteractorInterface {
}

enum Checkout {

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
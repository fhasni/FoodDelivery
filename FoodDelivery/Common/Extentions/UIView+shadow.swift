//
//  UIView+shadow.swift
//  FoodDelivery
//
//  Created by fhasni on 11/18/20.
//  Copyright © 2020 fhasni. All rights reserved.
//

import UIKit

extension UIView {
    func applyShadow() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 12.0
        layer.shadowOpacity = 0.2
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}

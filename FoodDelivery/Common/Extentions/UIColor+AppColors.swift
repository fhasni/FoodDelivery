//
//  UIColor+AppColors.swift
//  FoodDelivery
//
//  Created by fhasni on 11/2/20.
//  Copyright © 2020 fhasni. All rights reserved.
//

import UIKit

extension UIColor {
    static let appGreen = UIColor(red: 71/255, green: 192/255, blue: 63/255, alpha: 1)
    
    static func random() -> UIColor {
         return UIColor(red: .random(in: 0...1),
                              green: .random(in: 0...1),
                              blue: .random(in: 0...1),
                              alpha: 1.0)
    }
}


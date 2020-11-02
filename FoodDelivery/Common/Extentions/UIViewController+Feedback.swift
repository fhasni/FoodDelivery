//
//  UIViewController+Feedback.swift
//  FoodDelivery
//
//  Created by fhasni on 10/24/20.
//  Copyright © 2020 fhasni. All rights reserved.
//

import UIKit
import JGProgressHUD


extension UIViewController {
    func showLoader(withText text: String? = "") -> JGProgressHUD {
        view.endEditing(true)
        let loader = JGProgressHUD(style: .dark)
        loader.textLabel.text = text
        loader.show(in: view)
        return loader
    }

    func showAlert(title:String? = "", message: String? = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .cancel))
        present(alert, animated: true, completion: nil)
    }
}

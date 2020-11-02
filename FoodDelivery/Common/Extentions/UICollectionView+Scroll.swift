//
//  UICollectionView+Scroll.swift
//  FoodDelivery
//
//  Created by fhasni on 10/24/20.
//  Copyright © 2020 fhasni. All rights reserved.
//

import UIKit


extension UICollectionView {
    func scrollToLast() {
        guard numberOfSections > 0 else {
            return
        }

        let lastSection = numberOfSections - 1

        guard numberOfItems(inSection: lastSection) > 0 else {
            return
        }

        let lastItemIndexPath = IndexPath(item: numberOfItems(inSection: lastSection) - 1,
                                          section: lastSection)
        scrollToItem(at: lastItemIndexPath, at: .bottom, animated: true)
    }
}

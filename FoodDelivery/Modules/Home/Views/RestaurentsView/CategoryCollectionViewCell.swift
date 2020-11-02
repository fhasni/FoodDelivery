//
//  RestaurentCell.swift
//  FoodDelivery
//
//  Created by fhasni on 10/25/20.
//  Copyright © 2020 fhasni. All rights reserved.
//

import UIKit


final class CategoryCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryCollectionViewCell {
    func configureUI() {
        let label: UILabel = {
            let label = UILabel()
            label.text = "hello world"
            label.setDimensions(height: 50, width: 100)
            return label
        }()
        addSubview(label)
        label.centerX(inView: self)
        label.centerY(inView: self)
        
        backgroundColor = [UIColor.systemGreen, UIColor.systemBlue, UIColor.systemPink, UIColor.systemTeal, UIColor.systemIndigo].randomElement()
    }
}

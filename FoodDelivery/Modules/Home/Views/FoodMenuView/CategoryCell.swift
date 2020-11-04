//
//  RestaurentCell.swift
//  FoodDelivery
//
//  Created by fhasni on 10/25/20.
//  Copyright © 2020 fhasni. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class CategoryCell: UICollectionViewCell {
    
    // MARK: - Public properties -

    var category: Category? {
        didSet {
            categoryNameLabel.text = category?.name
        }
    }
        
    // MARK: - Private properties -

    private lazy var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Category name"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.setDimensions(height: 50)
        return label
    }()
    
    // MARK: - Lifecycle -

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryCell {
    func configureUI() {
        
        addSubview(categoryNameLabel)
        categoryNameLabel.centerX(inView: self)
        categoryNameLabel.centerY(inView: self)
        
        backgroundColor = .systemOrange
    }
}

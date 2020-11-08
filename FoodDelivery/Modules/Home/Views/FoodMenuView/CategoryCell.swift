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
    
    override var isSelected: Bool {
        didSet {
            categoryNameLabel.textColor = isSelected ? .black : .lightGray
            selectBarIndicator.isHidden = !isSelected
        }
    }
    
    // MARK: - Private properties -

    private lazy var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Category name"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var selectBarIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 1
        view.isHidden = true
        return view
    }()
    
    // MARK: - Lifecycle -

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with category: Category) {
        self.category = category
    }
}

extension CategoryCell {
    func setupUI() {
        
        addSubview(categoryNameLabel)
        categoryNameLabel.anchor(top: topAnchor, left: leftAnchor,
                                 bottom: bottomAnchor, right: rightAnchor)
        
        addSubview(selectBarIndicator)
        selectBarIndicator.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,
                                  paddingLeft: 20, paddingRight: 20, height: 2)
    }
}

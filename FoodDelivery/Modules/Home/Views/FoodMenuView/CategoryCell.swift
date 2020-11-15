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
import SnapKit

final class CategoryCell: UICollectionViewCell {
    
    // MARK: - Public properties -
    static let reuseIdentifier = "CategoryCell"
    
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
        categoryNameLabel.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
        
        addSubview(selectBarIndicator)
        selectBarIndicator.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(self)
            make.height.equalTo(2)

        }
        
    }
}

//
//  DishCell.swift
//  FoodDelivery
//
//  Created by fhasni on 11/1/20.
//  Copyright © 2020 fhasni. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift
import RxRelay
import RxCocoa
import SnapKit

final class DishCell: UITableViewCell {
    
    // MARK: - Public properties -
    
    static let reuseIdentifier = "DishCell"
    
    var dish : Dish? {
        didSet {
            dishNameLabel.text = dish?.name
            dishDescriptionLabel.text = dish?.description
            if let price = dish?.price {
                addToCartButton.setTitle("$\(price)", for: .normal)
            }
            
            if let image = dish?.image {
                dishImageView.sd_setImage(with: URL(string: image))
            }
        }
    }
    
    lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 25
        return button
    }()
    
    // MARK: - Private properties -

    private lazy var dishImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPink
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var dishNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    private lazy var dishDescriptionLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: - Lifecycle -

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions -

private extension DishCell {
    
    func setupUI() {
        
//        let cardView = CardView()
        let cardView: UIView = {
            let view = UIView()
            view.applyShadow()
            return view
        }()
        
        contentView.addSubview(cardView)
        cardView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 15, left: 30, bottom: 15, right: 30))
        }
        
        let dishViewContainer:  UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.layer.cornerRadius = 20
            view.clipsToBounds = true
            return view
        }()
        
        cardView.addSubview(dishViewContainer)
        dishViewContainer.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(cardView)
        }
        
        let detailsView : UIView = {
            let view = UIView()
            return view
        }()
        
        dishViewContainer.addSubview(detailsView)
        detailsView.snp.makeConstraints { (make) -> Void in
            make.left.bottom.right.equalTo(dishViewContainer)
            make.height.equalTo(200)
        }
        
        dishViewContainer.addSubview(dishImageView)
        dishImageView.snp.makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(dishViewContainer)
            make.bottom.equalTo(detailsView.snp.top)
        }
        
        detailsView.addSubview(dishNameLabel)
        dishNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(detailsView).offset(10)
            make.left.equalTo(detailsView).offset(20)
            make.right.equalTo(detailsView).offset(-20)
        }
        
        detailsView.addSubview(dishDescriptionLabel)
        dishDescriptionLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(dishNameLabel.snp.bottom).offset(10)
            make.left.equalTo(detailsView).offset(20)
            make.right.equalTo(detailsView).offset(-20)
        }
        
        detailsView.addSubview(addToCartButton)
        addToCartButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(detailsView).offset(-20)
            make.right.equalTo(detailsView).offset(-20)
            make.height.equalTo(50)
            make.width.equalTo(120)
        }
    }
}

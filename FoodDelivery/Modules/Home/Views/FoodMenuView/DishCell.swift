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
import RxCocoa

final class DishCell: UITableViewCell {
    
    // MARK: - Public properties -
    
    var dish : Dish? {
        didSet {
            dishNameLabel.text = dish?.name
            dishDescriptionLabel.text = dish?.description
            if let price = dish?.price {
                addToCartButton.setTitle("\(price) usd", for: .normal)
            }
            
            if let image = dish?.image {
                dishImageView.sd_setImage(with: URL(string: image))
            }
        }
    }
    
    // MARK: - Private properties -
    
    private let disposeBag = DisposeBag()

    private lazy var dishImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPink
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var dishNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.setDimensions(height: 50)
        return label
    }()
    
    private lazy var dishDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .lightGray
        label.setDimensions(height: 50)
        return label
    }()
    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.setDimensions(height: 50, width: 120)
        button.layer.cornerRadius = 25
        return button
    }()
    
    // MARK: - Lifecycle -

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions -

private extension DishCell {
    func setupView() {
        configureUI()
    }
    
    func configureUI() {
        
        let cardView = CardView()
        
        addSubview(cardView)
        cardView.anchor(top: topAnchor, left: leftAnchor,
                        bottom: bottomAnchor, right: rightAnchor,
                        paddingTop: 15, paddingLeft: 30,
                        paddingBottom: 15, paddingRight: 30)
        
        let dishViewContainer:  UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.layer.cornerRadius = 20
            view.clipsToBounds = true
            return view
        }()
        
        cardView.addSubview(dishViewContainer)
        dishViewContainer.anchor(top: cardView.topAnchor, left: cardView.leftAnchor,
                                 bottom: cardView.bottomAnchor, right: cardView.rightAnchor)
        
        let detailsView : UIView = {
            let view = UIView()
            view.setDimensions(height: 200)
            return view
        }()
        
        dishViewContainer.addSubview(detailsView)
        detailsView.anchor(left: dishViewContainer.leftAnchor, bottom: dishViewContainer.bottomAnchor,
                           right: dishViewContainer.rightAnchor)
        
        dishViewContainer.addSubview(dishImageView)
        dishImageView.anchor(top: dishViewContainer.topAnchor ,left: dishViewContainer.leftAnchor,
                         bottom: detailsView.topAnchor, right: dishViewContainer.rightAnchor)
    
        detailsView.addSubview(dishNameLabel)
        dishNameLabel.anchor(top: detailsView.topAnchor, left: detailsView.leftAnchor,
                        right: detailsView.rightAnchor, paddingTop: 10,
                        paddingLeft: 20, paddingRight: 20)
        
        detailsView.addSubview(dishDescriptionLabel)
        dishDescriptionLabel.anchor(top: dishNameLabel.bottomAnchor, left: detailsView.leftAnchor,
                        right: detailsView.rightAnchor, paddingTop: 0,
                        paddingLeft: 20, paddingRight: 20)
        
        detailsView.addSubview(addToCartButton)
        addToCartButton.anchor(bottom: detailsView.bottomAnchor, right: detailsView.rightAnchor,
                               paddingBottom: 20, paddingRight: 20)
    }
}

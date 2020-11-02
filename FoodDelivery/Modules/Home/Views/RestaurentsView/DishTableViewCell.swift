//
//  DishTableViewCell.swift
//  FoodDelivery
//
//  Created by fhasni on 11/1/20.
//  Copyright © 2020 fhasni. All rights reserved.
//

import UIKit
import SDWebImage

final class DishTableViewCell: UITableViewCell {
    

    // MARK: - Public properties -
    
    var dish : Dish?
    
    // MARK: - Private properties -
    
    private lazy var dishImage : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPink
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        guard let image = dish?.image else { return imageView}
        imageView.sd_setImage(with: URL(string: image))
        return imageView
    }()
    
    
    private lazy var dishName: UILabel = {
        let label = UILabel()
        label.text = dish?.name ?? "Dish name"
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.setDimensions(height: 50)
        return label
    }()
    
    private lazy var dishDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = dish?.description ?? "Dish description line 1\nDish description line 2"
        label.textColor = .lightGray
        label.setDimensions(height: 50)
        return label
    }()
    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.appGreen, for: .highlighted)
        button.setDimensions(height: 50, width: 100)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(handleAddToCart), for: .touchUpInside)
        guard let price = dish?.price else { return button}
        button.setTitle("\(price)", for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DishTableViewCell {
    
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
        
        dishViewContainer.addSubview(dishImage)
        dishImage.anchor(top: dishViewContainer.topAnchor ,left: dishViewContainer.leftAnchor,
                         bottom: detailsView.topAnchor, right: dishViewContainer.rightAnchor)
    
        detailsView.addSubview(dishName)
        dishName.anchor(top: detailsView.topAnchor, left: detailsView.leftAnchor,
                        right: detailsView.rightAnchor, paddingTop: 10,
                        paddingLeft: 20, paddingRight: 20)
        
        detailsView.addSubview(dishDescription)
        dishDescription.anchor(top: dishName.bottomAnchor, left: detailsView.leftAnchor,
                        right: detailsView.rightAnchor, paddingTop: 0,
                        paddingLeft: 20, paddingRight: 20)
        
        detailsView.addSubview(addToCartButton)
        addToCartButton.anchor(bottom: detailsView.bottomAnchor, right: detailsView.rightAnchor,
                               paddingBottom: 20, paddingRight: 20)
    }
}


extension DishTableViewCell {
    @objc func handleAddToCart() {
        print("handleAddToCart")
    }
}

//
//  CartDishCellTableViewCell.swift
//  FoodDelivery
//
//  Created by fhasni on 11/15/20.
//  Copyright © 2020 fhasni. All rights reserved.
//

import UIKit

class CartItemCell: UITableViewCell {
    
    // MARK: - Public properties -
    static let reuseIdentifier = "CartItemCell"
    
    var cartItem : CartItem? {
        didSet {
            nameLabel.text = cartItem?.dish?.name
            if let price = cartItem?.dish?.price, let count = cartItem?.count {
                priceDetailsLabel.text = "$\(price) x \(count) = $\(price*Double(count))"
            }
            
            if let image = cartItem?.dish?.image {
                dishImageView.sd_setImage(with: URL(string: image))
            }
        }
    }
    
    lazy var removeItemButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.systemRed.withAlphaComponent(0.7)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 15
        return button
    }()
    
    lazy var incrementItemButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.7)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 15
        return button
    }()
    
    lazy var decrementItemButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.7)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 15
        return button
    }()
    
    // MARK: - Private properties -
    
    private lazy var dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPink
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5

        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    private lazy var priceDetailsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
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

private extension CartItemCell {
    
    func setupUI() {
        
        let cardView = CardView()
        
        addSubview(cardView)
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
            make.top.right.bottom.equalTo(dishViewContainer)
            make.width.equalTo(200)
        }
        
        dishViewContainer.addSubview(dishImageView)
        dishImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(dishViewContainer).offset(10)
            make.left.equalTo(dishViewContainer).offset(10)
            make.bottom.equalTo(dishViewContainer).offset(-10)
            make.right.equalTo(detailsView.snp.left).offset(-10)
        }
        
        detailsView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(detailsView).offset(10)
            make.left.equalTo(detailsView).offset(20)
            make.right.equalTo(detailsView).offset(-20)
        }
        
        detailsView.addSubview(removeItemButton)
        removeItemButton.snp.makeConstraints { (make) -> Void in
            make.right.bottom.equalTo(detailsView).offset(-20)
            make.width.height.equalTo(30)
        }
        
        detailsView.addSubview(decrementItemButton)
        decrementItemButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(detailsView).offset(-20)
            make.left.equalTo(detailsView).offset(20)
            make.width.height.equalTo(30)
        }
        
        detailsView.addSubview(incrementItemButton)
        incrementItemButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(detailsView).offset(-20)
            make.left.equalTo(decrementItemButton.snp.right).offset(20)
            make.width.height.equalTo(30)
        }
        
        detailsView.addSubview(priceDetailsLabel)
        priceDetailsLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(removeItemButton.snp.top).offset(-10)
            make.left.equalTo(detailsView).offset(20)
            make.right.equalTo(detailsView).offset(-20)
        }
    }
}

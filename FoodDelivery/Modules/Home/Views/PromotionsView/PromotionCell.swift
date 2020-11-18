//
//  PromotionCell.swift
//  FoodDelivery
//
//  Created by fhasni on 11/18/20.
//  Copyright © 2020 fhasni. All rights reserved.
//

import UIKit

class PromotionCell: UICollectionViewCell {
    
    static let reuseIdentifier = "PromotionCell"

    var image : UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

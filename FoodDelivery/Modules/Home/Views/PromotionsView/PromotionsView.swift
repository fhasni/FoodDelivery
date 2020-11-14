//
//  PromotionsView.swift
//  FoodDelivery
//
//  Created by fhasni on 10/24/20.
//  Copyright © 2020 fhasni. All rights reserved.
//

import UIKit
import SnapKit

private let reuseIdentifier = "PromotionCell"

final class PromotionsView: UIView {
    
    // MARK: - Public properties -

    var presenter: HomePresenterInterface!
    
    // MARK: - Private properties -

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.contentInset = UIEdgeInsets(top:0, left: 0, bottom: 0, right: 0)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentOffset = .zero

        return collectionView
    }()

    private let images = [#imageLiteral(resourceName: "promotion3"), #imageLiteral(resourceName: "promotion2"), #imageLiteral(resourceName: "promotion1")]
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = self.images.count
        pageControl.pageIndicatorTintColor = UIColor(displayP3Red: 255.0/255, green: 255.0/255, blue: 255.0/255, alpha: 0.8)
        return pageControl
    }()
    
    // MARK: - Lifecycle -

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        resizePageControlCurrent()
    }
    
    // MARK: - Helpers -

    func setupUI() {

        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-70)
        }
    }
    
    func resizePageControlCurrent () {
        pageControl.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
        
        pageControl.subviews[pageControl.currentPage].transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
    }
}

// MARK: - Extensions -

extension PromotionsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        let imageView = UIImageView(image: images[indexPath.row])
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        cell.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(cell)
        }
        
        cell.backgroundColor = .systemIndigo
        return cell
    }
}

extension PromotionsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: -40, left: 0, bottom: 0, right: 0)
//    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
    }
}

extension PromotionsView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        resizePageControlCurrent()
    }

}



//
//  PromotionsView.swift
//  FoodDelivery
//
//  Created by fhasni on 10/24/20.
//  Copyright © 2020 fhasni. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

private let reuseIdentifier = "PromotionCell"

final class PromotionsView: UIView {
    
    // MARK: - Public properties -

    var presenter: HomePresenterInterface!
    
    // MARK: - Private properties -
    
    private let disposeBag = DisposeBag()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.register(PromotionCell.self, forCellWithReuseIdentifier: PromotionCell.reuseIdentifier)
        collectionView.contentInset = UIEdgeInsets(top:0, left: 0, bottom: 0, right: 0)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentOffset = .zero
        return collectionView
    }()

    
    private let images = Observable.just([#imageLiteral(resourceName: "promotion3"), #imageLiteral(resourceName: "promotion2"), #imageLiteral(resourceName: "promotion1")])
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
//        pageControl.numberOfPages = self.images.va.count
        pageControl.pageIndicatorTintColor = UIColor(displayP3Red: 255.0/255, green: 255.0/255, blue: 255.0/255, alpha: 0.8)
        return pageControl
    }()
    
    // MARK: - Lifecycle -

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupRx()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers -

    func setupRx() {
        images.asObservable()
            .bind(to: self.collectionView.rx.items(cellIdentifier: PromotionCell.reuseIdentifier, cellType: PromotionCell.self)) { row, image, cell in
                    cell.image = image
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        images.asObservable()
            .map { $0.count }
            .bind(to: pageControl.rx.numberOfPages)
            .disposed(by: disposeBag)
    }
    
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
    
//    func resizePageControlCurrent () {
//        pageControl.subviews.forEach {
//            $0.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
//        }
//
//        pageControl.subviews[pageControl.currentPage].transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
//    }
}

// MARK: - Extensions -

extension PromotionsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
}

extension PromotionsView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
    }
}



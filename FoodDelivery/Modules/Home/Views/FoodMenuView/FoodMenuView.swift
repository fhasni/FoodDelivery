//
//  RestaurentsView.swift
//  FoodDelivery
//
//  Created by fhasni on 10/25/20.
//  Copyright © 2020 fhasni. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private let categoryReuseIdentifier = "CategoryCell"
private let dishReuseIdentifier = "DishCell"

final class FoodMenuView: UIView {
    
    // MARK: - Public properties -
    
    var presenter: HomePresenterInterface
    
    // MARK: - Private properties -
    
    private let disposeBag = DisposeBag()
    
    private let headerView : UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = .init(width: UIScreen.main.bounds.width/3, height: 50)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInsetAdjustmentBehavior = .never
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.contentOffset = .zero
        cv.register(CategoryCell.self, forCellWithReuseIdentifier: categoryReuseIdentifier)
        cv.backgroundColor = .white
        return cv
    }()
    
    private lazy var dishTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(DishCell.self, forCellReuseIdentifier: dishReuseIdentifier)
        tableView.rowHeight = 550
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        return tableView
    }()
    
    private let openCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "cart"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.setDimensions(height: 56, width: 56)
        button.layer.cornerRadius = 56/2
        return button
    }()
    
    // MARK: - Lifecycle -
    init(presenter: HomePresenterInterface) {
        self.presenter = presenter
        super.init(frame: .zero)
        setupView()
        setupUI()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Extensions -
private extension FoodMenuView {
    
    func setupView() {
        let input = presenter.configure(with: Home.ViewOutput())
        
        let categories = input.categories.share()
        
        // bind categoryCollectionView
        categories.bind(to: categoryCollectionView.rx
                                .items(cellIdentifier: categoryReuseIdentifier,
                                       cellType: CategoryCell.self)) { (row, category, cell) in
                                        cell.category = category
            }
            .disposed(by: disposeBag)
        
        // select first item of categoryCollectionView
        categories.subscribe(onNext: {[unowned self] categories in
                if categories.count > 0 {
                    
                    // wait to allow loading
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        let indexPath = IndexPath(row: 0, section: 0)
                        self.categoryCollectionView.selectItem(at: indexPath,
                                                               animated: false,
                                                               scrollPosition: .bottom)
                        self.categoryCollectionView.delegate?.collectionView?(self.categoryCollectionView,
                                                                              didSelectItemAt: indexPath)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        let dishes = categoryCollectionView.rx
            .modelSelected(Category.self)
            .map { category -> [Dish] in
                category.dishes
            }
            .share()
        
        // bind dishesTableView based on selected category
        dishes.bind(to: dishTableView.rx
            .items(cellIdentifier: dishReuseIdentifier,
                   cellType: DishCell.self)) { (row, dish, cell) in
                    cell.dish = dish
            }
            .disposed(by: disposeBag)
        
        dishes.subscribe(onNext: {[unowned self] dishes in
                if dishes.count > 0 {
                    let indexPath = IndexPath(row: 0, section: 0)
                    self.dishTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func setupUI() {
        
        layer.cornerRadius = 40
        clipsToBounds = true
        backgroundColor = .white
        
        addSubview(headerView)
        headerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 150)
        
        headerView.addSubview(categoryCollectionView)
        categoryCollectionView.anchor(left: headerView.leftAnchor,
                                      bottom: headerView.bottomAnchor,
                                      right: headerView.rightAnchor,
                                      height: 100)
        
        addSubview(dishTableView)
        dishTableView.anchor(top: headerView.bottomAnchor, left: leftAnchor,
                               bottom: bottomAnchor, right: rightAnchor)
        
        addSubview(openCartButton)
        openCartButton.anchor(bottom: bottomAnchor, right: rightAnchor,
                              paddingBottom: 24, paddingRight: 24)
        
    }
}

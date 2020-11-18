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
import RxGesture

final class FoodMenuView: UIView {
    
    // MARK: - Public properties -
    
    var presenter: HomePresenterInterface
    
    // MARK: - Private properties -
    
    private let disposeBag = DisposeBag()
    
    
    
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = .init(width: UIScreen.main.bounds.width/3, height: 50)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInsetAdjustmentBehavior = .never
        cv.showsHorizontalScrollIndicator = false
        cv.contentOffset = .zero
        cv.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
        cv.backgroundColor = .white
        return cv
    }()
    
    private lazy var dishTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(DishCell.self, forCellReuseIdentifier: DishCell.reuseIdentifier)
        tableView.rowHeight = 550
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private let pannableView = UIView()
    
    private let openCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "cart"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.layer.cornerRadius = 56/2
        button.applyShadow()
        return button
    }()
    
    private lazy var cartCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .systemGreen
        label.layer.cornerRadius = 26/2
        label.clipsToBounds = true
        return label
    }()
    
    // MARK: - Lifecycle -
    
    init(presenter: HomePresenterInterface) {
        self.presenter = presenter
        super.init(frame: .zero)
        setupRx()
        setupUI()
        setupGestures()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Extensions -
private extension FoodMenuView {
    
    func setupRx() {
        let addToCartTapped = PublishSubject<Dish>()

        let output = Home.ViewOutput(openCartTapped: openCartButton.rx.tap.asObservable(),
                                     addToCartTapped: addToCartTapped)
        
        let input = presenter.configure(with: output)
        
        input.cartItemsCount
            .drive(cartCountLabel.rx.text)
            .disposed(by: disposeBag)

        // Bind categories to categoryCollectionView
        input.categories
            .drive(categoryCollectionView.rx.items(cellIdentifier: CategoryCell.reuseIdentifier, cellType: CategoryCell.self)) { (row, category, cell) in
                cell.category = category
            }
            .disposed(by: disposeBag)
        
        // Select first item of categoryCollectionView
        input.categories.asObservable().subscribe(onNext: { [weak self] categories in
                if categories.count > 0 {
                    // wait to allow loading of categories
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        self?.selectCategory(at: IndexPath(row: 0, section: 0))
                    }
                }
            })
            .disposed(by: disposeBag)
        
        // Dishes of selected caterogy
        let dishes = categoryCollectionView.rx
                        .modelSelected(Category.self)
                        .map { category -> [Dish] in
                            category.dishes
                        }
                
        // Bind dishes to dishTableView
        dishes.bind(to: dishTableView.rx
            .items(cellIdentifier: DishCell.reuseIdentifier, cellType: DishCell.self)) { (row, dish, cell) in
                cell.dish = dish
                cell.addToCartButton.rx.tap
                    .map { dish }
                    .bind(to: addToCartTapped)
                    .disposed(by: cell.rx.reuseBag)

            }
            .disposed(by: disposeBag)
        
        // Scroll to top dish after changing category
        dishes.subscribe(onNext: {[weak self] dishes in
                if dishes.count > 0 {
                    self?.dishTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func setupGestures() {
         let panGesture = pannableView.rx
             .panGesture(configuration: { gestureRecognizer, delegate in
                 delegate.simultaneousRecognitionPolicy = .custom { gestureRecognizer, otherGestureRecognizer in
                    return  !(otherGestureRecognizer.view?.isKind(of: UITableView.self) ?? false)
                 }
             })
             .share()
         
         panGesture
            .when(.began,.changed)
            .asTranslation()
            .subscribe(onNext: { [weak self] in
                 print("DEBUG: Pan gesture began or changed")
                 
                 self?.pannableView.transform = CGAffineTransform(translationX: $0.translation.x, y: 0)
                 self?.pannableView.alpha = 0.5
                 self?.dishTableView.isScrollEnabled = false
                 
            })
            .disposed(by: disposeBag)

         panGesture
            .when(.ended)
            .subscribe(onNext: { [weak self] translation in
                 print("DEBUG: Pan gesture ended")
                 let screenWidth = UIScreen.main.bounds.width

                 let restoreTableView = {
                     self?.dishTableView.isScrollEnabled = true
                     self?.pannableView.transform = CGAffineTransform(translationX: 0, y: 0)
                     self?.pannableView.alpha = 1
                 }
                 
                 let loadNext: (Bool) -> () = { isNext in
                     UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
                         self?.pannableView.transform = CGAffineTransform(translationX: isNext ? -screenWidth : screenWidth, y: 0)
                         self?.pannableView.alpha = 0
                     }, completion: { finished in
                         self?.pannableView.transform = CGAffineTransform(translationX: isNext ? screenWidth : -screenWidth, y: 0)
                         isNext ? self?.selectNextCategory() : self?.selectPreviousCategory()
                         UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
                             self?.pannableView.transform = CGAffineTransform(translationX: 0, y: 0)
                             self?.pannableView.alpha = 1
                         }, completion: { finished in
                             self?.dishTableView.isScrollEnabled = true
                             
                         })
                     })
                 }
                 
                guard let tx = self?.pannableView.transform.tx else {
                    restoreTableView()
                    return
                }
                
                 if tx > screenWidth/10 {
                     loadNext(false)
                 } else if tx < -screenWidth/10 {
                     loadNext(true)
                 } else {
                     restoreTableView()
                 }
        
            })
            .disposed(by: disposeBag)
    }
    
    func setupUI() {
        
        layer.cornerRadius = 40
        clipsToBounds = true
        backgroundColor = .white
        
        let headerView = UIView()
        
        addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(150)
        }
        
        headerView.addSubview(categoryCollectionView)
        categoryCollectionView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(headerView)
            make.height.equalTo(100)
        }
        
        addSubview(pannableView)
        pannableView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.bottom.right.equalTo(self)
        }
        
        pannableView.addSubview(dishTableView)
        dishTableView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(pannableView)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
        
        addSubview(openCartButton)
        openCartButton.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(-24)
            make.size.equalTo(56)
        }
        
        addSubview(cartCountLabel)
        cartCountLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(-65)
            make.right.equalTo(-24)
            make.size.equalTo(26)
        }
    }
    
    func selectCategory(at indexPath: IndexPath) {
        categoryCollectionView.selectItem(at: indexPath, animated: true,
                                          scrollPosition: .centeredHorizontally)
        categoryCollectionView.delegate?.collectionView?(categoryCollectionView,
                                                              didSelectItemAt: indexPath)
    }
    
    func selectNextCategory() {
        print("DEBUG: Should select next category")
        // get indexPath of current category
        guard let selectedIndexPath = categoryCollectionView.indexPathsForSelectedItems?[0] else { return }
        let targetIndexPath = IndexPath(row: selectedIndexPath.row + 1, section: selectedIndexPath.section)
        // make sure that the indexPath stays in bounds
        if targetIndexPath.row > categoryCollectionView.numberOfItems(inSection: 0) - 1 { return }
        selectCategory(at: targetIndexPath)
    }
    
    func selectPreviousCategory() {
        print("DEBUG: Should select previous category")
        // get indexPath of current category
        guard let selectedIndexPath = categoryCollectionView.indexPathsForSelectedItems?[0] else { return }
        let targetIndexPath = IndexPath(row: selectedIndexPath.row - 1, section: selectedIndexPath.section)
        // make sure that the indexPath stays in bounds
        if targetIndexPath.row < 0  { return }
        selectCategory(at: targetIndexPath)
    }
    
}

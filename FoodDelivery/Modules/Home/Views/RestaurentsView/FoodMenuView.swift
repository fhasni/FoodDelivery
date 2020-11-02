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

private let categoryReuseIdentifier = "CategoryCollectionViewCell"
private let dishReuseIdentifier = "DishTableViewCell"

final class FoodMenuView: UIView {
    
    // MARK: - Public properties -
    
    var presenter: HomePresenterInterface!
    
    // MARK: - Private properties -
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: categoryReuseIdentifier)
        collectionView.backgroundColor = .none
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DishTableViewCell.self, forCellReuseIdentifier: dishReuseIdentifier)
        tableView.rowHeight = 550
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        return tableView
    }()
    
    let headerView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        return view
    }()
    
    // MARK: - Lifecycle -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers -
    
    func configureUI() {
        
        layer.cornerRadius = 40
        clipsToBounds = true
        backgroundColor = .white
        
        addSubview(headerView)
        headerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 150)
        
        headerView.addSubview(collectionView)
        collectionView.anchor(top: headerView.bottomAnchor, left: headerView.leftAnchor, bottom: headerView.bottomAnchor, right: headerView.rightAnchor)
        
        addSubview(tableView)
        tableView.anchor(top: headerView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
    }
}

// MARK: - Extensions -
private extension FoodMenuView {
    func setupView() {
        
    }
}

extension FoodMenuView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryReuseIdentifier, for: indexPath)
        return cell
    }
}

extension FoodMenuView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/3, height: headerView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension FoodMenuView: UITableViewDelegate {
    
}

extension FoodMenuView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: dishReuseIdentifier, for: indexPath)
        return cell
    }
    
}

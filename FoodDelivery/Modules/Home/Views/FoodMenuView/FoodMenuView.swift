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
        
    private lazy var dishesTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(DishCell.self, forCellReuseIdentifier: dishReuseIdentifier)
        tableView.rowHeight = 550
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        return tableView
    }()
    
    private let headerView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.setDimensions(height: 150)
        return view
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
        headerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        
        let customView: UIView = {
            let view = UIView()
            view.backgroundColor = .systemBlue
            view.setDimensions(height: 100)
            return view
        }()
        
        headerView.addSubview(customView)
        
        customView.anchor(left: headerView.leftAnchor,
                          bottom: headerView.bottomAnchor,
                          right: headerView.rightAnchor)
        
        
        addSubview(dishesTableView)
        dishesTableView.anchor(top: headerView.bottomAnchor, left: leftAnchor,
                               bottom: bottomAnchor, right: rightAnchor)
        
        
        addSubview(openCartButton)
        openCartButton.anchor(bottom: bottomAnchor, right: rightAnchor,
                              paddingBottom: 24, paddingRight: 24)
        
    }
}

// MARK: - Extensions -
private extension FoodMenuView {
    func setupView() {
        let output = Home.ViewOutput()
        
        let input = presenter.configure(with: output)
        
        input.menu.asObservable()
            .map{ $0?.categories?[1].dishes ?? [] }
            .bind(to: dishesTableView.rx.items(cellIdentifier: dishReuseIdentifier, cellType: DishCell.self)) { (row,dish,cell) in
                cell.dish = dish
            }
            .disposed(by: disposeBag)
        
        configureUI()

    }
}


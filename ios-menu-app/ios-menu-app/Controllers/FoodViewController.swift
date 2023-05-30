//
//  FoodViewController.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/30.
//

import UIKit
import SwiftUI

final class FoodViewController: UIViewController {

    // MARK: Properties - View
    private lazy var foodModalView = FoodModalView()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureHierarchy()
        configureNavigationBarItem()
    }
    
    private func configureHierarchy() {
        
        view.addSubview(foodModalView)
        
        NSLayoutConstraint.activate([
            foodModalView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            foodModalView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            foodModalView.topAnchor.constraint(equalTo: view.topAnchor),
            foodModalView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureNavigationBarItem() {
        
        let checkItem = UIBarButtonItem(image: ImageSystemName.check.image,
                                        style: .plain,
                                        target: self,
                                        action: #selector(TappedCheckButton))
        checkItem.tintColor = .designSystem(.calendarDayGray)
        let deleteItem = UIBarButtonItem(image: ImageSystemName.trash.image,
                                         style: .plain,
                                         target: self,
                                         action: #selector(TappedDeleteButton))
        deleteItem.tintColor = .designSystem(.calendarDayGray)
        navigationItem.rightBarButtonItem = checkItem
        navigationItem.leftBarButtonItem = deleteItem
    }
    
    @objc private func TappedCheckButton() {
        
        print("check 버튼 눌림")
    }
    
    @objc private func TappedDeleteButton() {
        
        print("delete 버튼 눌림")
    }
}

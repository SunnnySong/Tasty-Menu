//
//  CalendarViewController.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/18.
//

import UIKit

final class CalendarViewController: UIViewController {
    
    private let dateCalcutaor = DateCalculator()
    private var calendarView = CalendarCollectionView(frame: .zero)
    private lazy var dataSourceProvider = CalendarDiffableDataSourceProvider<DateCell>(collectionView: calendarView, items: dateCalcutaor.getDate())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureHierarchy()
        configureDataSource()
    }
    
    private func configureHierarchy() {
        
        view.addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.topAnchor),
            calendarView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            calendarView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureDataSource() {
        
        let dataSource = dataSourceProvider.makeDataSource()
        dataSourceProvider.update()
        calendarView.dataSource = dataSource
        
    }
}

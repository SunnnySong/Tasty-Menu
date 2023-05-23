//
//  CalendarManager.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/23.
//

import UIKit

final class CalendarManager {
    
    private let calendarDiffableDataSourceProvider = CalendarDiffableDataSourceProvider()
    private let dateCalculator = DateCalculator()
  
    // MARK: Properties - Data
    private var headerDate: Date? {
        didSet {
            print("CalendarManager headerDate 변경")
        }
    }
    
    private var baseDate: Date? {
        didSet {
            print("CalendarManager baseDate 변경")
        }
    }
    
    private weak var collectionView: UICollectionView?
    private var dataSource: CalendarDiffableDataSourceProvider.DataSource?
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }

    func createDataSource() {
        
        guard let collectionView = collectionView else { return }
        
        guard let dataSource = calendarDiffableDataSourceProvider.dataSource(collectionView: collectionView) else {
            return
        }
        collectionView.dataSource = dataSource
        self.dataSource = dataSource
        update()
    }
    
    func update() {
        
        guard let dataSource = dataSource else {
            return
        }
        calendarDiffableDataSourceProvider.updateSnapshot(dateCalculator.getMonthlyDayData(), to: dataSource)
    }
    
}

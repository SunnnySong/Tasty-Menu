//
//  CalendarManager.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/23.
//

import UIKit

final class CalendarManager {
    
    // MARK: Properties - Data
    private let calendarDiffableDataSourceProvider = CalendarDiffableDataSourceProvider()
    private lazy var dateCalculator = DateCalculator(baseDate: baseDate)

    private var baseDate: Date = Date() {
        didSet {
            daysData = dateCalculator.getDaysInMonth(for: baseDate)
        }
    }
    
    private lazy var daysData: [Day] = dateCalculator.getDaysInMonth(for: baseDate) {
        didSet {
            update()
        }
    }
    
    // MARK: Properties - View
    private weak var collectionView: UICollectionView?
    private var dataSource: CalendarDiffableDataSourceProvider.DataSource?
    
    // MARK: Lifecycle
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }

    // MARK: Functions - Public
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
        calendarDiffableDataSourceProvider.updateSnapshot(daysData, to: dataSource)
    }
    
    func moveToPreviousMonth() -> Date {
        
        baseDate = dateCalculator.calculatePreviousMonth(by: baseDate)
        return baseDate
    }
    
    func moveToNextMonth() -> Date {
        
        baseDate = dateCalculator.calculateNextMonth(by: baseDate)
        return baseDate
    }
}

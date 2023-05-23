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
    private let dateCalculator = DateCalculator()
    
    private var selectedDate: Date = Date() {
        didSet {
            // 초기 설정: 오늘, 이후에는 사용자가 클릭한 날짜로 selectedDate 변경
            update()
        }
    }

    private var baseDate: Date = Date() {
        didSet {
            daysData = dateCalculator.getDaysInMonth(for: baseDate, selectedDate: selectedDate)
        }
    }
    
    private lazy var daysData: [Day] = dateCalculator.getDaysInMonth(for: baseDate, selectedDate: selectedDate) {
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

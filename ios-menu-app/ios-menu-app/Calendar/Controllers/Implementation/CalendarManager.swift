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
    private let notificationCenter = NotificationCenter.default
    private lazy var dateCalculator = DateCalculator(baseDate: baseDate)
    
    private var baseDate: Date = .today {
        didSet {
            updateDaysData()
        }
    }
    
    private var daysData: [DayComponent]? {
        didSet {
            updateSnapshot()
        }
    }
    
    // MARK: Properties - View
    private weak var collectionView: UICollectionView?
    private var dataSource: CalendarDiffableDataSourceProvider.DataSource?
    
    // MARK: Lifecycle
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        
        tappedHeaderPreviousButton()
        tappedHeaderNextButton()
    }
    
    // MARK: Functions - Public
    func getDaysData() -> [DayComponent] {
        
        guard let daysData = daysData else { return [] }
        return daysData
    }
    
    func updateDaysData() {
        
        daysData = dateCalculator.getDaysInMonth(for: baseDate)
    }
    
    func createDataSource() {
        
        guard let collectionView = collectionView else { return }
        
        guard let dataSource = calendarDiffableDataSourceProvider.dataSource(collectionView: collectionView) else {
            return
        }
        collectionView.dataSource = dataSource
        self.dataSource = dataSource
    }
    
    // MARK: Functions - Private
    private func updateSnapshot() {
        
        guard let dataSource = dataSource,
                let daysData = daysData else {
            return
        }
        
        calendarDiffableDataSourceProvider.updateSnapshot(header: baseDate, calendar: daysData, dataSource: dataSource)
    }
    
    private func tappedHeaderPreviousButton() {
        
        notificationCenter.addObserver(
            self,
            selector: #selector(moveToPreviousMonth),
            name: .tappedPreviousButton,
            object: nil)
    }
    
    private func tappedHeaderNextButton() {
        
        notificationCenter.addObserver(
            self,
            selector: #selector(moveToNextMonth),
            name: .tappedNextButton,
            object: nil)
    }
    
    @objc private func moveToPreviousMonth() {
        
        baseDate = dateCalculator.calculatePreviousMonth(by: baseDate)
    }
    
    @objc private func moveToNextMonth() -> Date {
        
        baseDate = dateCalculator.calculateNextMonth(by: baseDate)
        return baseDate
    }
}

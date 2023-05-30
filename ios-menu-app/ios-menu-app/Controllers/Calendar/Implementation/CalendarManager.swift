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
            daysData = dateCalculator.getDaysInMonth(for: baseDate)
        }
    }
    
    private lazy var daysData: [DayComponent] = dateCalculator.getDaysInMonth(for: baseDate) {
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
        return daysData
    }
    
    func createDataSource() {
        
        guard let collectionView = collectionView else { return }
        
        guard let dataSource = calendarDiffableDataSourceProvider.dataSource(collectionView: collectionView) else {
            return
        }
        collectionView.dataSource = dataSource
        self.dataSource = dataSource
        updateSnapshot()
    }
    
    func updateHeartState(indexPath: IndexPath) {

        daysData[indexPath.item].hasHeart.toggle()
    }
    
    // MARK: Functions - Private
    private func updateSnapshot() {
        
        guard let dataSource = dataSource else {
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

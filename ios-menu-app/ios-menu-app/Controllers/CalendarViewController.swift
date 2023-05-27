//
//  CalendarViewController.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/18.
//

import UIKit

final class CalendarViewController: UIViewController {
    
    // MARK: Properties - Data
    private lazy var calendarManager = CalendarManager(collectionView: calendarView)
    private let calendarCollectionViewDelegate = CalendarCollectionViewDelegate()
    
    // MARK: Properties - View
    private lazy var headerDateView: HeaderDateView = { [weak self] in
        HeaderDateView (
            didTapPreviousButton: {
                let previousBaseDate = self?.calendarManager.moveToPreviousMonth() ?? .today
                self?.headerDateView.updateHeaderDate(previousBaseDate)
            },
            didTapNextButton: {
                let nextBaseDate = self?.calendarManager.moveToNextMonth() ?? .today
                self?.headerDateView.updateHeaderDate(nextBaseDate)
            },
            headerDate: .today,
            type: .calendar
        )
    }()
    
    private var calendarView = CalendarCollectionView(frame: .zero)
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureHierarchy()
        configureDataSource()
        configureCollectionViewDelegate()
    }
    
    // MARK: Functions - private
    private func configureHierarchy() {
        
        view.addSubview(headerDateView)
        view.addSubview(calendarView)
        
        let calendarTotalHeight = view.frame.height
        let headerDateViewHeight = calendarTotalHeight * 0.11
        
        NSLayoutConstraint.activate([
            headerDateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerDateView.heightAnchor.constraint(equalToConstant: headerDateViewHeight),
            headerDateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerDateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            calendarView.topAnchor.constraint(equalTo: headerDateView.bottomAnchor),
            calendarView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            calendarView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureDataSource() {
        
        calendarManager.createDataSource()
    }
    
    // MARK: CollectionView delegate 설정
    private func configureCollectionViewDelegate() {
        
//        calendarView.delegate = calendarCollectionViewDelegate
//        calendarCollectionViewDelegate.calendarDelegate = calendarManager
    }
}

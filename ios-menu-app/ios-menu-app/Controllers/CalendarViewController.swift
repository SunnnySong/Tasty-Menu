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
                let previousBaseDate = self?.calendarManager.moveToPreviousMonth() ?? Date()
                self?.headerDateView.updateHeaderDate(previousBaseDate)
            },
            didTapNextButton: {
                let nextBaseDate = self?.calendarManager.moveToNextMonth() ?? Date()
                self?.headerDateView.updateHeaderDate(nextBaseDate)
            }
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
        let calendarTotalWidth = view.frame.width
        
        let headerDateViewSize = calendarTotalHeight * 0.11
        let headerDateViewWidth = calendarTotalWidth * 0.57
        let headerDateViewHeight = headerDateViewSize / 2.3
        let headerTopConstant = (headerDateViewSize - headerDateViewHeight) / 2
        
        NSLayoutConstraint.activate([
            headerDateView.widthAnchor.constraint(equalToConstant: headerDateViewWidth),
            headerDateView.heightAnchor.constraint(equalToConstant: headerDateViewHeight),
            headerDateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerDateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: headerTopConstant),
            headerDateView.bottomAnchor.constraint(equalTo: calendarView.topAnchor, constant: -headerTopConstant),
            
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

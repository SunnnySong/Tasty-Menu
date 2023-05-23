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
    
    // MARK: Properties - View
    private lazy var headerDateView: HeaderDateView = { [weak self] in
        HeaderDateView (
            didTapPreviousButton: {
                self?.calendarManager.moveToPreviousMonth()
//                self?.headerDateView.updateHeaderDate(date: self?.dateCalculator.getMonthlyDay() ?? Date())
            },
            didTapNextButton: {
                self?.calendarManager.moveToNextMonth()
//                self?.headerDateView.updateHeaderDate(date: self?.dateCalculator.getMonthlyDay() ?? Date())
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
}

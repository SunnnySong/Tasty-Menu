//
//  CalendarViewController.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/18.
//

import UIKit
import SwiftUI

final class CalendarViewController: UIViewController {
    
    // MARK: Properties - Data
    private lazy var calendarManager = CalendarManager(collectionView: calendarView)
    
    // MARK: Properties - View
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
        
        view.addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureDataSource() {
        
        calendarManager.createDataSource()
        calendarManager.updateDaysData()
    }
    
    // MARK: CollectionView delegate 설정
    private func configureCollectionViewDelegate() {
        
        calendarView.delegate = self
    }
}

extension CalendarViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let menuPopupViewController = MenuPopupViewController()
        setupPopupViewController(menuPopupViewController, indexPath: indexPath)
       
        present(menuPopupViewController, animated: true)
    }
    
    func setupPopupViewController(_ menuPopupViewController: MenuPopupViewController, indexPath: IndexPath) {
        
        menuPopupViewController.modalPresentationStyle = .overFullScreen
        menuPopupViewController.modalTransitionStyle = .crossDissolve
        
        let selectedItem = calendarManager.getDaysData()[indexPath.item]
        menuPopupViewController.updateDay(selectedItem.date)
        
        menuPopupViewController.heartStateCallback = { [weak self] in
            
            self?.calendarManager.updateDaysData()
        }
    }
}

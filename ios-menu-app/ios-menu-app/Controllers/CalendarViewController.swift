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
    }
    
    // MARK: CollectionView delegate 설정
    private func configureCollectionViewDelegate() {
        
        calendarView.delegate = self
    }
}

extension CalendarViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedItem = calendarManager.getDaysData()[indexPath.item]
        
        let menuPopupViewController = MenuPopupViewController()
        menuPopupViewController.updateDay(selectedItem.date)
        menuPopupViewController.modalPresentationStyle = .overFullScreen
        
        present(menuPopupViewController, animated: true)
    }
}

struct ViewController_Previews: PreviewProvider {   // 이름 바꿔도 됨
    
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        
        func makeUIViewController(context: Context) -> UIViewController {
            return CalendarViewController()    // <- 미리 볼 뷰컨 인스턴스
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            
        }
        
    }
    
}

//
//  CalendarCollectionViewDelegate.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/25.
//

import UIKit

final class CalendarCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    // MARK: Properties - Data
    weak var calendarDelegate: CalendarDelegate?

    // MARK: Functions - Public
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        calendarDelegate?.calendarView(collectionView, didSelectItemAt: indexPath)
    }
}

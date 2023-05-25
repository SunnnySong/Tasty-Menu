//
//  CalendarDelegate.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/26.
//

import UIKit

protocol CalendarDelegate: AnyObject {
    
    func calendarView(_ calendarView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

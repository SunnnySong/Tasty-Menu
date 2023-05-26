//
//  CalendarDelegate.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/26.
//

import UIKit

protocol CalendarDelegate: AnyObject {
    
    // 추후 calendar에서 popup view 로 데이터 전송할 때 사용
    func calendarView(_ calendarView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

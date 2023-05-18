//
//  TabBarModel.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/18.
//

import UIKit

enum TabBarModel: CaseIterable {
    case list
    case calendar
    case pushAlarm
    
    var viewController: UIViewController {
        switch self {
        case .list:
            return ListViewController()
        case .calendar:
            return CalendarViewController()
        case .pushAlarm:
            return PushAlarmViewController()
        }
    }
    
    var title: String {
        switch self {
        case .list:
            return "리스트"
        case .calendar:
            return "캘린더"
        case .pushAlarm:
            return "푸시알림"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .list:
            return UIImage(systemName: "list.clipboard.fill")
        case .calendar:
            return UIImage(systemName: "calendar")
        case .pushAlarm:
            return UIImage(systemName: "bell.fill")
        }
    }
}

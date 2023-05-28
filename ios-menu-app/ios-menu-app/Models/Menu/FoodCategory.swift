//
//  FoodCategory.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/29.
//

import UIKit

enum FoodCategory: Int32 {
    
    case korean
    case japanese
    case chinese
    case western
    case etc
    
    var title: String {
        switch self {
        case .korean:
            return "한식"
        case .japanese:
            return "일식"
        case .chinese:
            return "중식"
        case .western:
            return "양식"
        case .etc:
            return "그외"
        }
    }
    
    var backgroundColor: UIColor? {
        switch self {
        case .korean:
            return .systemBlue
        case .japanese:
            return .systemYellow
        case .chinese:
            return .systemRed
        case .western:
            return .systemPink
        case .etc:
            return .designSystem(.calendarDayGray)
        }
    }
}

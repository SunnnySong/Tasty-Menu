//
//  FoodCategory.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/29.
//

import UIKit

enum FoodCategory: Int32, CaseIterable {
    
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
            return .designSystem(.category1)
        case .japanese:
            return .designSystem(.category2)
        case .chinese:
            return .designSystem(.category3)
        case .western:
            return .designSystem(.category4)
        case .etc:
            return .designSystem(.category5)
        }
    }
}

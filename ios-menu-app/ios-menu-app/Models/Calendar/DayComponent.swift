//
//  Day.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/22.
//

import Foundation

struct DayComponent: Hashable {
    
    let date: Date
    let isIncludeInMonth: Bool
    var hasHeart: Bool = false
    var headerType: Bool = false
}

extension DayComponent {
    
    var number: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        
        return formatter.string(from: date)
    }
}

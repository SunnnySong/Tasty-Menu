//
//  Day.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/22.
//

import Foundation

// MARK: 네이밍 ?
struct Day: Hashable {
    
    let date: Date
    let isIncludeInMonth: Bool
    var hasHeart: Bool = false
    var headerType: Bool = false
    
    func reversed() -> Day {
        var result = self
        result.headerType = !result.headerType
        
        return result
    }
}

extension Day {
    
    var number: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        
        return formatter.string(from: date)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
        hasher.combine(headerType)
    }
}

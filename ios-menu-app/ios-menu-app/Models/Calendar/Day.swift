//
//  Day.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/22.
//

import Foundation

struct Day: Hashable {
    
    let date: Date
    let isIncludeInMonth: Bool
    var hasHeart: Bool = false
}

extension Day {
    
    var number: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        
        return formatter.string(from: date)
    }
}

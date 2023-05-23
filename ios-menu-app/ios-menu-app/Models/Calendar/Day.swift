//
//  Day.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/22.
//

import Foundation

struct Day: Hashable {
    
    let date: Date
    let number: String
    var isSelected: Bool
    let isIncludeInMonth: Bool
    var hasHeart: Bool = false
}

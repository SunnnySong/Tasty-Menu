//
//  Section.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/23.
//

import Foundation

enum Section: Int, CaseIterable {
    case headerDate
    case main
}

struct Item: Hashable {
    let headerDate: Date
    let calendarDay: Day
}

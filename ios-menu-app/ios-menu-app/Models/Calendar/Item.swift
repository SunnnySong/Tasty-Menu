//
//  Item.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/30.
//

import Foundation

enum Item: Hashable {
    case header(Date)
    case calendar(DayComponent)
}

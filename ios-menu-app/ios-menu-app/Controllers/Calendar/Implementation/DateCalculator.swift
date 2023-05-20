//
//  DateCalculator.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/21.
//

import Foundation

struct DateCalculator {
    
    private var mockDate: Array<Int> = Array(0..<42)
    private let weak = ["일", "월", "화", "수", "목", "금", "토",]
    
    func getDate() -> [Int] {
        mockDate
    }
    
    func getWeakTitle() -> [String] {
        weak
    }
}

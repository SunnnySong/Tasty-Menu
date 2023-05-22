//
//  DateCalculator.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/21.
//

import Foundation

final class DateCalculator {
    
    // MARK: Properties - Data
    private let calendar = Calendar(identifier: .gregorian)
    
    private var selectedDate: Date = Date()
    private var baseDate: Date = Date() {
        didSet {
            monthlyDayData = getDaysInMonth(for: baseDate)
            // headerview에서도 새로운 basedata 기준으로 update
        }
    }
    private lazy var monthlyDayData = getDaysInMonth(for: baseDate)
    
    // MARK: Functions - Public
    func getMonthlyDayData() -> [Day] {
        monthlyDayData
    }
    
    func getMonthlyDay() -> Date {
        baseDate
    }
    
    func moveToNextMonth() {
        
        guard let nextMonth = calendar.date(byAdding: .month, value: 1, to: baseDate) else {
            return
        }
        baseDate = nextMonth
    }
    
    func moveToPreviousMonth() {
        
        guard let previousMonth = calendar.date(byAdding: .month, value: -1, to: baseDate) else {
            return
        }
        baseDate = previousMonth
    }
    
    // MARK: Functions - Private
    private func getMonthlyDay(for baseDate: Date) throws -> MonthlyDay {
        
        guard let numberOfDaysInMonth = calendar.range(
            of: .day, in: .month, for: baseDate)?.count,
              let firstDayOfMonth = calendar.date(
                from: calendar.dateComponents([.year, .month], from: baseDate))
        else {
            throw CalendarError.isFailGenerateMonthlyDay
        }
        
        let firstDayWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        let monthlyDay = MonthlyDay(numberOfDays: numberOfDaysInMonth, firstDay: firstDayOfMonth, firstDayWeekday: firstDayWeekday)
        
        return monthlyDay
    }
    
    private func getDaysInMonth(for baseDate: Date) -> [Day] {
        
        guard let monthlyData = try? getMonthlyDay(for: baseDate) else {
            return []
        }
        
        let numberOfDays = monthlyData.numberOfDays
        let firstDayOfMonth = monthlyData.firstDay
        let offsetInFirstRow = monthlyData.firstDayWeekday
        
        var days: [Day] = (1..<(numberOfDays + offsetInFirstRow)).map { day in
            
            let isIncludeInMonth = day >= offsetInFirstRow
            let dayOffset = isIncludeInMonth ? (day - offsetInFirstRow) : -(offsetInFirstRow - day)
            
            let day = generateDay(offsetBy: dayOffset, for: firstDayOfMonth, isIncludeInMonth: isIncludeInMonth)
            
            return day
        }
        
        days += generateStartOfNextMonth(using: firstDayOfMonth)
        
        return days
    }
    
    private func generateDay(offsetBy dayOffset: Int, for baseDate: Date, isIncludeInMonth: Bool) -> Day {
        
        let date = calendar.date(byAdding: .day, value: dayOffset, to: baseDate) ?? baseDate
        let day = Day(date: date,
                      number: generateDayNumber(date),
                      isSelected: calendar.isDate(date, inSameDayAs: selectedDate),
                      isIncludeInMonth: isIncludeInMonth)
        
        return day
    }
    
    private func generateStartOfNextMonth(using currentMonth: Date) -> [Day] {
        
        guard let lastDay = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: currentMonth) else {
            return []
        }
        
        let additionalDays = 7 - calendar.component(.weekday, from: lastDay)
        guard additionalDays > 0 else {
            return []
        }
        
        let days: [Day] = (1...additionalDays).map {
            generateDay(offsetBy: $0, for: lastDay, isIncludeInMonth: false)
        }
        
        return days
    }
    
    private func generateDayNumber(_ date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        
        return formatter.string(from: date)
    }
}

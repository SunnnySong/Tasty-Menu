//
//  DateCalculator.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/21.
//

import Foundation

struct DateCalculator {
    
    // MARK: Properties - Data
    private let calendar = Calendar(identifier: .gregorian)
    
    // MARK: Functions - Public
    func calculateNextMonth(by baseDate: Date) -> Date {

        guard let nextMonth = calendar.date(byAdding: .month, value: 1, to: baseDate) else {
            return Date()
        }
        return nextMonth
    }

    func calculatePreviousMonth(by baseDate: Date) -> Date {

        guard let previousMonth = calendar.date(byAdding: .month, value: -1, to: baseDate) else {
            return Date()
        }
        return previousMonth
    }
    
    func getDaysInMonth(for baseDate: Date, selectedDate: Date) -> [Day] {
        
        guard let monthlyData = try? getMonth(for: baseDate) else {
            return []
        }
        let firstDayOfMonth = monthlyData.firstDay
        
        let daysInThisMonth = generateDays(for: baseDate, selectedDate: selectedDate)
        let daysInNextMonth = generateStartOfNextMonth(using: firstDayOfMonth, selectedDate: selectedDate)
        
        return daysInThisMonth + daysInNextMonth
    }
    
    // MARK: Functions - Private
    private func getMonth(for baseDate: Date) throws -> Month {
        
        guard let numberOfDaysInMonth = calendar.range(
            of: .day, in: .month, for: baseDate)?.count,
              let firstDayOfMonth = calendar.date(
                from: calendar.dateComponents([.year, .month], from: baseDate)) else {
            throw CalendarError.isFailGenerateMonthlyDay
        }
        
        let firstDayWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        let monthlyDay = Month(numberOfDays: numberOfDaysInMonth, firstDay: firstDayOfMonth, firstDayWeekday: firstDayWeekday)
        
        return monthlyDay
    }
    
    private func generateDay(offsetBy dayOffset: Int, for baseDate: Date, isIncludeInMonth: Bool, selectedDate: Date) -> Day {
        
        let date = calendar.date(byAdding: .day, value: dayOffset, to: baseDate) ?? baseDate
        let day = Day(date: date,
                      number: generateDayNumber(date),
                      isSelected: calendar.isDate(date, inSameDayAs: selectedDate),
                      isIncludeInMonth: isIncludeInMonth)
        
        return day
    }
    
    private func generateDays(for baseDate: Date, selectedDate: Date) -> [Day] {
        
        guard let monthlyData = try? getMonth(for: baseDate) else {
            return []
        }
        
        let numberOfDays = monthlyData.numberOfDays
        let firstDayOfMonth = monthlyData.firstDay
        let offsetInFirstRow = monthlyData.firstDayWeekday
        
        let days: [Day] = (1..<(numberOfDays + offsetInFirstRow)).map { day in
            
            let isIncludeInMonth = day >= offsetInFirstRow
            let dayOffset = isIncludeInMonth ? (day - offsetInFirstRow) : -(offsetInFirstRow - day)
            
            let day = generateDay(offsetBy: dayOffset, for: firstDayOfMonth, isIncludeInMonth: isIncludeInMonth, selectedDate: selectedDate)
            
            return day
        }
        
        return days
    }
    
    private func generateStartOfNextMonth(using currentMonth: Date, selectedDate: Date) -> [Day] {
        
        guard let lastDay = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: currentMonth) else {
            return []
        }
        
        let additionalDays = 7 - calendar.component(.weekday, from: lastDay)
        guard additionalDays > 0 else {
            return []
        }
        
        let days: [Day] = (1...additionalDays).map {
            generateDay(offsetBy: $0, for: lastDay, isIncludeInMonth: false, selectedDate: selectedDate)
        }
        
        return days
    }
    
    private func generateDayNumber(_ date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        
        return formatter.string(from: date)
    }
}

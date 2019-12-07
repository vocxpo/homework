//
//  CalendarExtension.swift
//  OneMonth
//
//  Created by 呉翰 on 2019/12/07.
//  Copyright © 2019 呉翰. All rights reserved.
//

import Foundation

extension Calendar {

    //MARK: - Day operations

    func endOfDay(for date:Date) -> Date {
        return nextDay(for: date)
    }

    func previousDay(for date:Date) -> Date {
        return move(date, byDays: -1)
    }

    func nextDay(for date:Date) -> Date {
        return move(date, byDays: 1)
    }

    //MARK: - Move operation

    func move(_ date:Date, byDays days:Int) -> Date {
        return self.date(byAdding: .day, value: days, to: startOfDay(for: date))!
    }
}

extension Calendar {

    //MARK: - Week operations

    func startOfWeek(for date:Date) -> Date {
        let comps = self.dateComponents([.weekOfYear, .yearForWeekOfYear], from: date)
        return self.date(from: comps)!
    }

    func endOfWeek(for date:Date) -> Date {
        return nextWeek(for: date)
    }

    func previousWeek(for date:Date) -> Date {
        return move(date, byWeeks: -1)
    }

    func nextWeek(for date:Date) -> Date {
        return move(date, byWeeks: 1)
    }

    //MARK: - Month operations

    func startOfMonth(for date:Date) -> Date {
        let comps = dateComponents([.month, .year], from: date)
        return self.date(from: comps)!
    }

    func endOfMonth(for date:Date) -> Date {
        return nextMonth(for: date)
    }

    func previousMonth(for date:Date) -> Date {
        return move(date, byMonths: -1)
    }

    func nextMonth(for date:Date) -> Date {
        return move(date, byMonths: 1)
    }

    //MARK: - Move operations

    func move(_ date:Date, byWeeks weeks:Int) -> Date {
        return self.date(byAdding: .weekOfYear, value: weeks, to: startOfWeek(for: date))!
    }

    func move(_ date:Date, byMonths months:Int) -> Date {
        return self.date(byAdding: .month, value: months, to: startOfMonth(for: date))!
    }
}

extension Calendar {

    //MARK: - inSame operations

    func isDate(_ date1:Date, inSameWeekAs date2:Date) -> Bool {
        return isDate(date1, equalTo: date2, toGranularity: .weekOfYear)
    }

    func isDate(_ date1:Date, inSameMonthAs date2:Date) -> Bool {
        return isDate(date1, equalTo: date2, toGranularity: .month)
    }
}

extension Calendar {

    //MARK: - Range operations

    func daysInMonth(for date:Date) -> Int {
        return range(of: .day, in: .month, for: date)!.count
    }

    func weeksInMonth(for date:Date) -> Int {
        return range(of: .weekOfMonth, in: .month, for: date)!.count
    }
}

extension Calendar {

    //MARK: - Range operations

    func days(from date1:Date, to date2:Date) -> Int {
        let comps = dateComponents([.day], from: startOfDay(for: date1), to: startOfDay(for: date2))
        return comps.day!
    }
}


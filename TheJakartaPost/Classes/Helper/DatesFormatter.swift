//
//  DatesFormatter.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 23/09/22.
//

import Foundation

enum DatesFormatter {
    case simpleResponse
    case response
    case timepast
    case calendarDate
    case calendarDay
    case calendarMonth
    case eventDate
    case dayName
    case globalDate
    case globalDateShortDay
    case globalDateShortDayWithYear
    case calendarMonthYear
    case formatTime
    case indonesialLocalwHours
    case simpleResponseSlash
    case calendarMonthDayYear
    case calendarFullMonthYear
    case dateFullMonth
    case hours
    case month
    case year
    case day
    case date
    case display
    
    func formatter() -> Foundation.DateFormatter {
        switch self {
        case .simpleResponse:
            return indonesianLocalFormatter(string: "yyyy-MM-dd")
        case .response:
            return indonesianLocalFormatter(string: "yyyy-MM-dd'T'HH:mm:ssZZZZ")
        case .timepast://2019-08-09 10:10:10
            return indonesianLocalFormatter(string: "yyyy-MM-dd HH:mm:ss")
        case .globalDate:
            return indonesianLocalFormatter(string: "dd MMM yyyy")
        case .dateFullMonth:
            return indonesianLocalFormatter(string: "dd MMMM yyyy")
        case .calendarDate:
            return indonesianLocalFormatter(string: "dd MMM")
        case .calendarDay:
            return indonesianLocalFormatter(string: "dd")
        case .month:
            return indonesianLocalFormatter(string: "MMM")
        case .year:
            return indonesianLocalFormatter(string: "yyyy")
        case .calendarMonth:
            return indonesianLocalFormatter(string: "MMMM")
        case .eventDate:
            return indonesianLocalFormatter(string: "dd-MMM")
        case .dayName:
            return indonesianLocalFormatter(string: "EEEE")
        case .day:
            return indonesianLocalFormatter(string: "EE")
        case .date:
            return indonesianLocalFormatter(string: "dd")
        case .globalDateShortDay:
            return indonesianLocalFormatter(string: "EE, dd MMM")
        case .globalDateShortDayWithYear:
            return indonesianLocalFormatter(string: "EE, dd MMM yyyy")
        case .calendarMonthYear:
            return indonesianLocalFormatter(string: "MMM yyyy")
        case .calendarFullMonthYear:
            return indonesianLocalFormatter(string: "MMMM yyyy")
        case .calendarMonthDayYear:
            return indonesianLocalFormatter(string: "MMMM dd yyyy")
        case .formatTime: //10:10:10
            return indonesianLocalFormatter(string: "HH:mm:ss")
        case .hours:
            return indonesianLocalFormatter(string: "HH:mm")
        case .indonesialLocalwHours:
            return indonesianLocalFormatter(string: "dd MMM yyyy HH:mm")
        case .simpleResponseSlash:
            return indonesianLocalFormatter(string: "dd/MM/yyyy")
        case .display:
            return indonesianLocalFormatter(string: "dd/MM/yyy, HH:mm(ZZZZ)")
        }
    }
    
    private func indonesianLocalFormatter(string: String) -> Foundation.DateFormatter {
        let localFormatter = Foundation.DateFormatter.dataFormatter(string)
        localFormatter.locale = Locale(identifier: "EN")
        return localFormatter
    }
    
    func stringFromDate(_ date: Date) -> String {
        return self.formatter().string(from: date)
    }
    
    func dateFromString(_ string: String) -> Date? {
        return self.formatter().date(from: string)
    }
    
}

extension Foundation.DateFormatter {
    @nonobjc static var standardDateFormatter: Foundation.DateFormatter = {
        let dateFormatter = Foundation.DateFormatter()
        return dateFormatter
    }()
    
    static func dataFormatter(_ format: String) -> Foundation.DateFormatter {
        let dateFormatter = standardDateFormatter
        dateFormatter.dateFormat = format
        return dateFormatter
    }
}

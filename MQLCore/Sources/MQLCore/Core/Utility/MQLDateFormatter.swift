//
//  Date+Extensions.swift
//
//
//  Created by Hemant Sudhanshu on 06/02/24.
//

import Foundation

public enum TimeFormat {
    case TWELVE_HOUR
    case TWENTY_FOUR_HOUR
}

public class MQLDateFormatter {
    public static func getFormattedDateString(date: Date, dateFormat: String) -> String {
         let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT:0)!
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = dateFormat
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
    
    public static func parseDateStringToDate(date: String, dateFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT:0)!
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: date)
    }
    
    public static func changeDateFormat(date: String, inputFormat: String, outputFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        
        guard let date = dateFormatter.date(from: date) else {
            return ""
        }
        print(date)
        dateFormatter.dateFormat = outputFormat
        let result = dateFormatter.string(from: date)
        return result
    }
    
    public static func getFormattedTime(time: Date, format: TimeFormat)  -> String {
        let dateFormatter = DateFormatter()
        
        if format == .TWELVE_HOUR {
            dateFormatter.dateFormat = "h:mm a"
        } else {
            dateFormatter.dateFormat = "HH:mm"
        }
        return dateFormatter.string(from: time)
    }
    
}

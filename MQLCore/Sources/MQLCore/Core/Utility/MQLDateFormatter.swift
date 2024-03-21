//
//  Date+Extensions.swift
//
//
//  Created by Hemant Sudhanshu on 06/02/24.
//

import Foundation

/**
 A utility class providing methods for date and time formatting.
 
 MQLDateFormatter encapsulates functionality to format date strings, parse date strings into date objects, change date formats, and format time strings.
 */
public class MQLDateFormatter {
    
    /**
     Returns a formatted date string according to the specified date format.
     
     - Parameters:
     - date: The date to be formatted.
     - dateFormat: The format string for the desired date format.
     - Returns: A formatted date string.
     */
    public static func getFormattedDateString(date: Date, dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT:0)!
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = dateFormat
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
    
    /**
     Returns a date object from a given date string according to the specified date format.
     
     - Parameters:
     - date: The date string to be parsed.
     - dateFormat: The format string for the given date string.
     - Returns: A date object if parsing succeeds, otherwise nil.
     */
    public static func parseDateStringToDate(date: String, dateFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT:0)!
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: date)
    }
    
    /**
     Returns a formatted date string converted from one format to another.
     
     - Parameters:
     - date: The date string to be converted.
     - inputFormat: The format string of the input date string.
     - outputFormat: The desired format string for the output date string.
     - Returns: A formatted date string converted from the input format to the output format.
     */
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
    
    /**
     Returns a formatted time string according to the specified time format.
     
     - Parameters:
     - time: The time object to be formatted.
     - format: The desired time format.
     - Returns: A formatted time string.
     */
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

/// An enumeration representing different time formats.
public enum TimeFormat {
    case TWELVE_HOUR
    case TWENTY_FOUR_HOUR
}

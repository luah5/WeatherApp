//
//  Int+toTimestamp.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 23/04/23.
//

import Foundation

/// Converts a unix time integer to a timestamp.
extension Int {
    func toTimestamp() -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(self))
        let utcDateFormatter = DateFormatter()
        utcDateFormatter.dateStyle = .medium
        utcDateFormatter.timeStyle = .short

        return utcDateFormatter.string(from: date as Date)
    }

    /// The full timestamp version
    func toTimestamp2() -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(self))
        let utcDateFormatter = DateFormatter()
        utcDateFormatter.dateStyle = .full
        utcDateFormatter.timeStyle = .full

        return utcDateFormatter.string(from: date as Date)
    }

    /// The hour version of the timestamp e.g 7:46 or 16:01
    func toTimestamp3() -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(self))
        let utcDateFormatter = DateFormatter()
        utcDateFormatter.dateStyle = .none
        utcDateFormatter.timeStyle = .short

        return utcDateFormatter.string(from: date as Date)
    }

    /// The day format of the timestamp e.g Saturday
    func toTimestamp4() -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(self))
        let utcDateFormatter = DateFormatter()
        utcDateFormatter.dateStyle = .full
        utcDateFormatter.timeStyle = .none

        return utcDateFormatter.string(from: date as Date).split(separator: ",").first!.toString()
    }

    func toTimestampWith(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(self))
        let utcDateFormatter = DateFormatter()
        utcDateFormatter.dateStyle = dateStyle
        utcDateFormatter.timeStyle = timeStyle

        return utcDateFormatter.string(from: date as Date)
    }
}

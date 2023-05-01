//
//  Int+ToTimestamp.swift
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
}

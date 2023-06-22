//
//  Int+getProperDateWord.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 28/04/23.
//

import Foundation

/// Extends Int and returns the proper way to say a date.
extension Int {
    /// Converts an Int to the suffix of a date
    /// - Returns: A String being the correct suffix for a date
    func getProperDateWord() -> String {
        let selfString: String = self.toString()
        let end: String = String(describing: selfString.last ?? "4")

        if end == "1" {
            return "st"
        } else if end == "2" {
            return "nd"
        } else if end == "3" {
            return "rd"
        }

        return "th"
     }
}

//
//  Int+getProperDateWord.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 28/04/23.
//

import Foundation

/// Extends Int and returns the proper way to say a date.
extension Int {
    func getProperDateWord() -> String {
        let selfString: String = String(describing: self)
        let end: String = String(describing: selfString.last ?? "4")

        if selfString.first == "1" {
            return "th"
        }

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

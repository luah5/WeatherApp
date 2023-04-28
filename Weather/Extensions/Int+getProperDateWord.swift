//
//  Int+getProperDateWord.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 28/04/23.
//

import Foundation

extension Int {
    func getProperDateWord() -> String {
        let selfString = String(describing: self)
        let end = String(describing: selfString.last ?? "4")

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

//
//  DegreesToCompassName.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 13/05/23.
//

import Foundation

let degreesCompass: [String] = [
    "N",
    "NE",
    "E",
    "SE",
    "S",
    "SW",
    "W",
    "NW",
    "N"
]

func degreesToCompassName(_ degrees: Int) -> String {
    return degreesCompass[degrees / 8]
}

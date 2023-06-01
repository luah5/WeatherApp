//
//  DegreesToCompassName.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 13/05/23.
//

import Foundation

let degreesCompass: [String] = [
    "North",
    "Northeast",
    "East",
    "Southeast",
    "South",
    "Southwest",
    "West",
    "Northwest",
    "North"
]

func degreesToCompassName(_ degrees: Int) -> String {
    return degreesCompass[degrees / 45]
}

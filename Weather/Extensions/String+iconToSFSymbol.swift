//
//  String+iconToSFSymbol.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 24/04/23.
//

import Foundation
import SwiftUI

/// Extends String so that an openweathermap.com icon can be converted to the apple-native SF Symbol.
extension String {
    func iconToSFSymbol() -> IconImage {
        var name: String = "Snow"

        if self == "01d" {
            name = "sun.max.fill"
        } else if self == "01n" {
            name = "moon.fill"
        } else if self == "02d" {
            name = "cloud.sun.fill"
        } else if self == "02n" {
            name = "cloud.moon.fill"
        } else if self.hasPrefix("03") || self.hasPrefix("04") {
            name = "cloud.fill"
        } else if self == "09d" || self == "09n" {
            name = "cloud.rain.fill"
        } else if self == "10d" {
            name = "cloud.sun.rain.fill"
        } else if self == "10n" {
            name = "cloud.moon.rain.fill"
        } else if self == "13d" || self == "13n" {
            name = "snowflake"
        } else if self == "50d" || self == "50n" {
            name = "cloud.fog.fill"
        }

        return IconImage(image: Image(systemName: name).symbolRenderingMode(.palette))
    }
}

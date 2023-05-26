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
            name = "Sun"
        } else if self == "01n" {
            name = "Moon"
        } else if self == "02d" {
            name = "Sun and cloud"
        } else if self == "02n" {
            name = "Moon and cloud"
        } else if self.hasPrefix("03") || self.hasPrefix("04") {
            name = "Cloud"
        } else if self == "09d" || self == "09n" {
            name = "Cloud and rain"
        } else if self == "10d" {
            name = "cloud.sun.rain.fill"
        } else if self == "10n" {
            name = "cloud.moon.rain.fill"
        } else if self == "13d" || self == "13n" {
            name = "Snow"
        } else if self == "50d" || self == "50n" {
            name = "cloud.fog.fill"
        }

        return IconImage(image: Image(name).resizable())
    }
}

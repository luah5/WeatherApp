//
//  String+iconToSFSymbol.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 24/04/23.
//

import Foundation
import SwiftUI

extension String {
    // swiftlint:disable cyclomatic_complexity
    func iconToSFSymbol() -> IconImage {
        var systemName: String = "exclamationmark.triangle.fill"
        var color: Color = .red

        if self.last == "d" {
            color = .white
        } else if self.last == "n" {
            color = .gray
        }
        if self == "01d" {
            systemName = "sun.max.fill"
            color = .yellow
        } else if self == "01n" {
            systemName = "moon.fill"
        } else if self == "02d" {
            systemName = "cloud.sun.fill"
        } else if self == "02n" {
            systemName = "cloud.moon.fill"
        } else if self == "03d" || self == "04d" {
            systemName = "cloud.fill"
        } else if self == "03n" || self == "04n" {
            systemName = "cloud.fill"
        } else if self == "09d" || self == "09n" {
            systemName = "cloud.rain.fill"
        } else if self == "10d" {
            systemName = "cloud.sun.rain.fill"
        } else if self == "10n" {
            systemName = "cloud.moon.rain.fill"
        } else if self == "13d" || self == "13n" {
            systemName = "snowflake"
            color = .black
        } else if self == "50d" || self == "50n" {
            systemName = "cloud.fog.fill"
            color = .white
        }

        return IconImage(image: Image(systemName: systemName), color: color)
    }
}
// swiftlint:enable cyclomatic_complexity

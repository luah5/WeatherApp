//
//  String+iconToBackground.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 28/05/23.
//

import Foundation
import SwiftUI

extension String {
    func iconToBackground() -> IconImage {
        var name: String = "Night"

        if self == "01d" {
            name = "Clear"
        } else if self == "01n" {
            name = "Night"
        } else if self == "02d" {
            name = "PartlyCloudy"
        } else if self == "02n" {
            name = "Moon and cloud"
        } else if self.hasPrefix("03") || self.hasPrefix("04") {
            name = "Cloudy"
        } else if self == "09d" || self == "09n" {
            name = "Cloud and rain"
        } else if self == "10d" {
            name = "Rain cloud and Sun"
        } else if self == "10n" {
            name = "Rain cloud and Moon"
        } else if self == "13d" || self == "13n" {
            name = "Snow"
        } else if self == "50d" || self == "50n" {
            name = "PartlyCloudy"
        }

        return IconImage(image: Image(name).resizable())
    }
}

//
//  String+iconToBackground.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 28/05/23.
//

import Foundation
import SwiftUI

extension String {
    func iconToBackground() -> IconImage {
        var name: String = "Night"
        var color: Color = .red

        if self == "01d" {
            name = "Clear"
            color = .blue
        } else if self == "01n" || self == "02n" {
            name = "Night"
            color = .black
        } else if self == "02d" || self == "50d" || self == "50n" {
            name = "PartlyCloudy"
            color = .blue
        } else if self.hasPrefix("03") || self.hasPrefix("04") {
            name = "Cloudy"
            color = .gray
        } else if self == "09d" || self == "09n" || self == "10d" {
            name = "Rainy"
            color = .blue
        } else if self == "10n" {
            name = "RainNight"
            color = Color(nsColor: .darkGray)
        } else if self == "13d" || self == "13n" {
            name = "Snowy"
            color = .white
        }

        return IconImage(
            image: Image(name).resizable(),
            color: color
        )
    }
}

//
//  WeatherDescription.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 22/04/23.
//

import Foundation
import SwiftUI

/// A struct for getting the weather description and icon
struct WeatherDescription {
    var mainDescription: String, description: String, icon: IconImage, background: IconImage

    /// Default intializer, takes one argument: a JSON object.
    init(json: JSON) {
        self.mainDescription = json["main"].stringValue
        self.description = json["description"].stringValue
        self.icon = json["icon"].stringValue.iconToSFSymbol()
        self.background = json["icon"].stringValue.iconToBackground()
    }
}

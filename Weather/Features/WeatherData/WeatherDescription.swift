//
//  WeatherDescription.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 22/04/23.
//

import Foundation
import SwiftyJSON
import SwiftUI

/// A struct for getting the weather description and icon
struct WeatherDescription {
    var mainDescription: String, description: String, icon: IconImage, background: IconImage

    /// Default intializer, takes one argument: a JSON object.
    init(json: JSON) {
        self.mainDescription = String(describing: json["main"])
        self.description = String(describing: json["description"])
        self.icon = String(describing: json["icon"]).iconToSFSymbol()
        self.background = String(describing: json["icon"]).iconToBackground()
    }
}

//
//  WeatherDescription.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 22/04/23.
//

import Foundation

/// A struct for getting the weather description and icon
struct WeatherDescription: Identifiable, Hashable {
    static func == (lhs: WeatherDescription, rhs: WeatherDescription) -> Bool {
        lhs.id == rhs.id
    }

    let id: UUID = UUID()
    let mainDescription: String, description: String, icon: IconImage, background: IconImage

    /// Default intializer, takes one argument: a JSON object.
    init(json: JSON) {
        self.mainDescription = json["main"].stringValue
        self.description = json["description"].stringValue
        self.icon = json["icon"].stringValue.iconToSFSymbol()
        self.background = json["icon"].stringValue.iconToBackground()
    }
}

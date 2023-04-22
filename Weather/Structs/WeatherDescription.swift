//
//  WeatherDescription.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 22/04/23.
//

import Foundation
import SwiftyJSON

struct WeatherDescription {
    var mainDescription: String, description: String

    init(json: JSON) {
        self.mainDescription = String(describing: json["main"])
        self.description = String(describing: json["description"])
    }
}

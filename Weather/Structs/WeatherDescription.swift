//
//  WeatherDescription.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 22/04/23.
//

import Foundation
import SwiftyJSON
import SwiftUI

struct WeatherDescription {
    var mainDescription: String, description: String, icon: Image

    init(json: JSON) {
        self.mainDescription = String(describing: json["main"])
        self.description = String(describing: json["description"])
        self.icon = String(describing: json["icon"]).iconToSFSymbol()
    }
}

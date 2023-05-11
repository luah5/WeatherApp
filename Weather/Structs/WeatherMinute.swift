//
//  WeatherMinute.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 09/05/23.
//

import Foundation
import SwiftyJSON

/// A struct for a weather minute using OpenWeatherMap's onecall API
struct WeatherMinute {
    var time: Int, precipitation: Float

    init(json: JSON) {
        self.time = Int(json["dt"].stringValue) ?? 1000
        self.precipitation = Float(json["precipitation"].stringValue) ?? 0
    }
}

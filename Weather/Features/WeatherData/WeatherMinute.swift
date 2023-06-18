//
//  WeatherMinute.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 09/05/23.
//

import Foundation

/// A struct for a weather minute using OpenWeatherMap's onecall API
struct WeatherMinute: Identifiable {
    let time: Int, precipitation: Float
    let id: UUID = UUID()

    init(json: JSON) {
        self.time = Int(json["dt"].stringValue) ?? 1000
        self.precipitation = Float(json["precipitation"].stringValue) ?? 0
    }
}

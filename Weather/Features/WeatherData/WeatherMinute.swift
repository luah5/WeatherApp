//
//  WeatherMinute.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 09/05/23.
//

import Foundation

/// A struct for a weather minute using OpenWeatherMap's onecall API
struct WeatherMinute: Identifiable, Hashable {
    let id: UUID = UUID()
    let time: Int, precipitation: Float

    init(json: JSON) {
        self.time = Int(json["dt"].stringValue) ?? 1000
        self.precipitation = Float(json["precipitation"].stringValue) ?? 0
    }
}

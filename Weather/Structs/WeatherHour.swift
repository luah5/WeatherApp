//
//  WeatherHour.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 22/04/23.
//

import Foundation
import SwiftyJSON

struct WeatherHour {
    var windGust: Float, pressure: Int, temp: Float, clouds: Int, dewPoint: Float, visibility: Int, time: Int
    var humidity: Int, feelsLike: Float, uvi: Int, windDeg: Int, windSpeed: Float, weather: WeatherDescription

    init(json: JSON) {
        windGust = Float(json["wind_gust"].stringValue) ?? -100
        pressure = Int(json["pressure"].stringValue) ?? -100
        temp = Float(json["temp"].stringValue) ?? -100
        clouds = Int(json["clouds"].stringValue) ?? -100
        dewPoint = Float(json["dew_point"].stringValue) ?? -100
        visibility = Int(json["visibility"].stringValue) ?? -100
        time = Int(json["dt"].stringValue) ?? -100

        humidity = Int(json["humidity"].stringValue) ?? -100
        feelsLike = Float(json["feels_like"].stringValue) ?? -100
        uvi = Int(json["uvi"].stringValue) ?? -100
        windDeg = Int(json["wind_deg"].stringValue) ?? -100
        windSpeed = Float(json["wind_speed"].stringValue) ?? -100

        weather = WeatherDescription(json: json["weather"][0])
    }
}
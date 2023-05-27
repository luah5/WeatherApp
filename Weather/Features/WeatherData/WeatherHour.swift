//
//  WeatherHour.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 22/04/23.
//

import Foundation
import SwiftyJSON

/// A weather hour contained by a WeatherDay
struct WeatherHour {
    var windGust: Float, pressure: Int, temp: Float, clouds: Int, dewPoint: Float, visibility: Int, time: Int
    var humidity: Int, feelsLike: Float, uvi: Int, windDeg: Float, windSpeed: Float, weather: WeatherDescription
    var precipitation: Float, chanceOfRain: Int, converted: Bool, windDegInt: Int

    init(json: JSON, isConverted: Bool, timezoneOffset: Int = 0) {
        converted = isConverted

        windGust = Float(json["wind_gust"].stringValue) ?? 0
        pressure = Int(json["pressure"].stringValue) ?? -100
        temp = Float(json["temp"].stringValue) ?? -100
        clouds = Int(json["clouds"].stringValue) ?? -100
        dewPoint = Float(json["dew_point"].stringValue) ?? -100
        visibility = Int((Float(String(json["visibility"].stringValue)) ?? -100) / 100)
        time = (Int(json["dt"].stringValue) ?? 1000) + timezoneOffset

        humidity = Int(json["humidity"].stringValue) ?? -100
        feelsLike = Float(json["feels_like"].stringValue) ?? -100
        uvi = Float(json["uvi"].stringValue)?.toInt() ?? 0
        windDeg = Float(json["wind_deg"].stringValue) ?? -100
        windDegInt = windDeg.toInt()
        windSpeed = Float(json["wind_speed"].stringValue) ?? -100
        chanceOfRain = Int((Int(json["pop"].stringValue) ?? 0) * 100)

        weather = WeatherDescription(json: json["weather"][0])

        precipitation = 0
        if json["rain"].exists() {
            precipitation = Float(json["rain"]["1h"].stringValue) ?? 0
        }
    }
}

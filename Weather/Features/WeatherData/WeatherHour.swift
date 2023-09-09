//
//  WeatherHour.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 22/04/23.
//

import Foundation

/// A weather hour contained by a WeatherDay
struct WeatherHour: Identifiable, Hashable {
    static func == (lhs: WeatherHour, rhs: WeatherHour) -> Bool {
        lhs.id == rhs.id
    }

    let windGust: Float, pressure: Int, temp: Float, clouds: Int, dewPoint: Float, visibility: Int, time: Int
    let humidity: Int, feelsLike: Float, uvi: Int, windDeg: Float, windSpeed: Float, weather: WeatherDescription
    var precipitation: Float, chanceOfRain: Int, converted: Bool, windDegInt: Int, snowPrecipitation: Float
    let id: UUID = UUID()

    init(json: JSON, isConverted: Bool, timezoneOffset: Int = 0) {
        self.converted = isConverted

        self.windGust = Float(json["wind_gust"].stringValue) ?? 0
        self.pressure = Int(json["pressure"].stringValue) ?? -100
        self.temp = Float(json["temp"].stringValue) ?? -100
        self.clouds = Int(json["clouds"].stringValue) ?? -100
        self.dewPoint = Float(json["dew_point"].stringValue) ?? -100
        self.visibility = Int((Float(String(json["visibility"].stringValue)) ?? -100) / 100)
        self.time = (Int(json["dt"].stringValue) ?? 1000) + timezoneOffset

        self.humidity = Int(json["humidity"].stringValue) ?? -100
        self.feelsLike = Float(json["feels_like"].stringValue) ?? -100
        self.uvi = Float(json["uvi"].stringValue)?.toInt() ?? 0
        self.windDeg = Float(json["wind_deg"].stringValue) ?? -100
        self.windDegInt = windDeg.toInt()
        self.windSpeed = Float(json["wind_speed"].stringValue) ?? -100
        self.chanceOfRain = Int((Int(json["pop"].stringValue) ?? 0) * 100)

        self.weather = WeatherDescription(json: json["weather"][0])

        self.precipitation = 0
        if json["rain"].exists() {
            self.precipitation = Float(json["rain"]["1h"].stringValue) ?? 0
        }

        self.snowPrecipitation = 0
        if json["snow"].exists() {
            self.snowPrecipitation = Float(json["snow"]["1h"].stringValue) ?? 0
        }
    }
}

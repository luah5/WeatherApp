//
//  WeatherDayDaily.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 27/05/23.
//

import Foundation

struct WeatherDayDaily {
    enum MoonPhase: String {
        case new = "New Moon"
        case waxingCrescent = "Waxing Crescent"
        case firstQuarter = "First Quarter"
        case waxingGibous = "Waxing Gibous"
        case full = "Full Moon"
        case waningGibous = "Waning Gibous"
        case lastQuarter = "Last Quarter"
        case waningCrescent = "Waning Crescent"
    }

    var weather: WeatherDescription, dewPoint: Float, humidity: Int, chanceOfRain: Float
    var temperatureDaily: TemperatureDaily, feelsLikeDaily: FeelsLikeDaily
    var windSpeed: Float, windGust: Float, windDirection: Int
    var moonPhase: MoonPhase, moonrise: Int, moonset: Int
    var sunrise: Int, sunset: Int
    var uvi: Int, pressure: Int, clouds: Int

    init(json: JSON) {
        weather = WeatherDescription(json: json["weather"][0])

        dewPoint = Float(json["dew_point"].stringValue) ?? 0
        humidity = Int(json["humidity"].stringValue) ?? 0
        chanceOfRain = Float(json["pop"].stringValue) ?? 0

        temperatureDaily = TemperatureDaily(json: json["temp"])
        feelsLikeDaily = FeelsLikeDaily(json: json["feels_like"])

        windSpeed = Float(json["wind_speed"].stringValue) ?? 0
        windGust = Float(json["wind_gust"].stringValue) ?? 0
        windDirection = Int(json["wind_deg"].stringValue) ?? 0

        let moonPhaseNum: Float = Float(json["moon_phase"].stringValue) ?? 0
        if moonPhaseNum == 0 || moonPhaseNum == 1 {
            moonPhase = .new
        } else if moonPhaseNum < 0.25 {
            moonPhase = .waxingCrescent
        } else if moonPhaseNum == 0.25 {
            moonPhase = .firstQuarter
        } else if moonPhaseNum < 0.5 {
            moonPhase = .waxingGibous
        } else if moonPhaseNum == 0.5 {
            moonPhase = .full
        } else if moonPhaseNum < 0.75 {
            moonPhase = .waningGibous
        } else if moonPhaseNum == 0.75 {
            moonPhase = .lastQuarter
        } else {
            moonPhase = .waningCrescent
        }

        moonrise = Int(json["moonrise"].stringValue) ?? 0
        moonset = Int(json["moonset"].stringValue) ?? 0

        sunrise = Int(json["sunrise"].stringValue) ?? 0
        sunset = Int(json["sunset"].stringValue) ?? 0

        uvi = Int(json["uvi"].stringValue) ?? 0
        pressure = Int(json["pressure"].stringValue) ?? 0
        clouds = Int(json["clouds"].stringValue) ?? 0
    }
}

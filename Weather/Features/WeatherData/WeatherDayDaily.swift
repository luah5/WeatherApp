//
//  WeatherDayDaily.swift
//  World Wide Weather
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

    let weather: WeatherDescription, dewPoint: Float, humidity: Int, chanceOfRain: Float
    let temperatureDaily: TemperatureDaily, feelsLikeDaily: FeelsLikeDaily
    let windSpeed: Float, windGust: Float, windDirection: Int
    let moonPhase: MoonPhase, moonrise: Int, moonset: Int
    let sunrise: Int, sunset: Int
    let uvi: Int, pressure: Int, clouds: Int

    init(json: JSON) {
        self.weather = WeatherDescription(json: json["weather"][0])

        self.dewPoint = Float(json["dew_point"].stringValue) ?? 0
        self.humidity = Int(json["humidity"].stringValue) ?? 0
        self.chanceOfRain = Float(json["pop"].stringValue) ?? 0

        self.temperatureDaily = TemperatureDaily(json: json["temp"])
        self.feelsLikeDaily = FeelsLikeDaily(json: json["feels_like"])

        self.windSpeed = Float(json["wind_speed"].stringValue) ?? 0
        self.windGust = Float(json["wind_gust"].stringValue) ?? 0
        self.windDirection = Int(json["wind_deg"].stringValue) ?? 0

        let moonPhaseNum: Float = Float(json["moon_phase"].stringValue) ?? 0
        if moonPhaseNum == 0 || moonPhaseNum == 1 {
            self.moonPhase = .new
        } else if moonPhaseNum < 0.25 {
            self.moonPhase = .waxingCrescent
        } else if moonPhaseNum == 0.25 {
            self.moonPhase = .firstQuarter
        } else if moonPhaseNum < 0.5 {
            self.moonPhase = .waxingGibous
        } else if moonPhaseNum == 0.5 {
            self.moonPhase = .full
        } else if moonPhaseNum < 0.75 {
            self.moonPhase = .waningGibous
        } else if moonPhaseNum == 0.75 {
            self.moonPhase = .lastQuarter
        } else {
            self.moonPhase = .waningCrescent
        }

        self.moonrise = Int(json["moonrise"].stringValue) ?? 0
        self.moonset = Int(json["moonset"].stringValue) ?? 0

        self.sunrise = Int(json["sunrise"].stringValue) ?? 0
        self.sunset = Int(json["sunset"].stringValue) ?? 0

        self.uvi = Int(json["uvi"].stringValue) ?? 0
        self.pressure = Int(json["pressure"].stringValue) ?? 0
        self.clouds = Int(json["clouds"].stringValue) ?? 0
    }
}

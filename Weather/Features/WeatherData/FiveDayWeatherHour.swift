//
//  FiveDayWeatherHour.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 26/04/23.
//

import Foundation

/// This struct exists so that when five days worth of weather data is loaded it can be converted to a WeatherHour.
struct FiveDayWeatherHour: Identifiable, Hashable {

    let id: UUID = UUID()
    let pressure: Int, temp: Float, minTemp: Float, maxTemp: Float, feelsLike: Float, humidity: Int
    var clouds: Int, weather: WeatherDescription, threeHourRain: Float, time: Int, icon: String, mainDesc: String
    let visibility: Int, windGust: Float, windDeg: Int, windSpeed: Float, chanceOfRain: Int, desc: String
    var threeHourSnow: Float

    init(json: JSON) {
        let mainJSON = json["main"]
        self.pressure = Int(mainJSON["pressure"].stringValue) ?? -100

        self.temp = Float(mainJSON["temp"].stringValue) ?? -100
        self.minTemp = Float(mainJSON["temp_min"].stringValue) ?? -100
        self.maxTemp = Float(mainJSON["temp_max"].stringValue) ?? -100
        self.feelsLike = Float(mainJSON["feels_like"].stringValue) ?? -100

        self.humidity = Int(mainJSON["humidity"].stringValue) ?? -100

        self.visibility = Int(Int(json["visibility"].stringValue) ?? -100 / 1000)

        self.windGust = Float(json["wind"]["gust"].stringValue) ?? -100
        self.windDeg = Int(json["wind"]["deg"].stringValue) ?? -100
        self.windSpeed = Float(json["wind"]["speed"].stringValue) ?? -100
        self.chanceOfRain = Int((Float(json["pop"].stringValue) ?? 0) * 100)

        self.threeHourRain = 0
        if json["rain"].exists() {
            self.threeHourRain = Float(json["rain"]["3h"].stringValue) ?? -100
        }

        self.threeHourSnow = 0
        if json["snow"].exists() {
            self.threeHourSnow = Float(json["snow"]["3h"].stringValue) ?? -100
        }

        self.time = Int(json["dt"].stringValue) ?? 0

        self.clouds = Int(json["clouds"]["all"].stringValue) ?? 0

        self.weather = WeatherDescription(json: json["weather"])
        self.icon = json["weather"][0]["icon"].stringValue
        self.mainDesc = json["weather"][0]["main"].stringValue.capitalized
        self.desc = json["weather"][0]["description"].stringValue.capitalized
    }
}

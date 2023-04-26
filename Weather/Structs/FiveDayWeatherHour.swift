//
//  FiveDayWeatherHour.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 26/04/23.
//

import Foundation
import SwiftyJSON

struct FiveDayWeatherHour {
    var pressure: Int, temp: Float, minTemp: Float, maxTemp: Float, feelsLike: Float, tempKf: Int, humidity: Int
    var groundLevel: Int, seaLevel: Int, clouds: Int, weather: WeatherDescription, threeHourRain: Float, time: Int
    var visibility: Int, windGust: Float, windDeg: Int, windSpeed: Float

    init(json: JSON) {
        let mainJSON = json["main"]
        pressure = Int(mainJSON["pressure"].stringValue) ?? -100

        temp = Float(mainJSON["temp"].stringValue) ?? -100
        minTemp = Float(mainJSON["temp_min"].stringValue) ?? -100
        maxTemp = Float(mainJSON["temp_max"].stringValue) ?? -100
        tempKf = Int(mainJSON["temp_kf"].stringValue) ?? -100
        feelsLike = Float(mainJSON["feels_like"].stringValue) ?? -100

        humidity = Int(mainJSON["humidity"].stringValue) ?? -100
        groundLevel = Int(mainJSON["grnd_level"].stringValue) ?? -100
        seaLevel = Int(mainJSON["sea_level"].stringValue) ?? -100

        visibility = Int(Int(json["visibility"].stringValue) ?? -100 / 1000)

        windGust = Float(json["wind"]["gust"].stringValue) ?? -100
        windDeg = Int(json["wind"]["deg"].stringValue) ?? -100
        windSpeed = Float(json["wind"]["speed"].stringValue) ?? -100

        if json["rain"].exists() {
            threeHourRain = Float(json["rain"]["3h"].stringValue) ?? -100
        } else {
            threeHourRain = 0
        }

        time = Int(json["dt"].stringValue) ?? 0

        if json["clouds"].exists() {
            clouds = Int(json["clouds"]["all"].stringValue) ?? -100
        } else {
            clouds = 0
        }

        weather = WeatherDescription(json: json["weather"])
    }
}

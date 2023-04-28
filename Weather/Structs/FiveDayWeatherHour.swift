//
//  FiveDayWeatherHour.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 26/04/23.
//

import Foundation
import SwiftyJSON

struct FiveDayWeatherHour {
    var pressure: Int, temp: Float, minTemp: Float, maxTemp: Float, feelsLike: Float, humidity: Int
    var clouds: Int, weather: WeatherDescription, threeHourRain: Float, time: Int, icon: String, mainDesc: String
    var visibility: Int, windGust: Float, windDeg: Int, windSpeed: Float, chanceOfRain: Int, desc: String

    init(json: JSON) {
        let mainJSON = json["main"]
        pressure = Int(mainJSON["pressure"].stringValue) ?? -100

        temp = Float(mainJSON["temp"].stringValue) ?? -100
        minTemp = Float(mainJSON["temp_min"].stringValue) ?? -100
        maxTemp = Float(mainJSON["temp_max"].stringValue) ?? -100
        feelsLike = Float(mainJSON["feels_like"].stringValue) ?? -100

        humidity = Int(mainJSON["humidity"].stringValue) ?? -100

        visibility = Int(Int(json["visibility"].stringValue) ?? -100 / 1000)

        windGust = Float(json["wind"]["gust"].stringValue) ?? -100
        windDeg = Int(json["wind"]["deg"].stringValue) ?? -100
        windSpeed = Float(json["wind"]["speed"].stringValue) ?? -100
        chanceOfRain = Int(Float(json["pop"].stringValue)! * 100)

        if json["rain"].exists() {
            threeHourRain = Float(json["rain"]["3h"].stringValue) ?? -100
        } else {
            threeHourRain = 0
        }

        time = Int(json["dt"].stringValue) ?? 0

        clouds = Int(json["clouds"]["all"].stringValue) ?? 0

        weather = WeatherDescription(json: json["weather"])
        icon = json["weather"][0]["icon"].stringValue
        mainDesc = json["weather"][0]["main"].stringValue.capitalized
        desc = json["weather"][0]["description"].stringValue.capitalized
    }
}

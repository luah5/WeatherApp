//
//  MultipleDayLoading.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 18/04/23.
//

import Foundation
import SwiftUI

let apiKey: String = "&appid=59b882df8e35c2c5eefe87e105b2d6df"
let units: String = "&units=metric"

/// Constructs the URL for getting weather data.
func constructURL(_ baseURL: String, _ location: String) -> String {
    return baseURL + location + apiKey + units
}

/// Throws an NSAlert with specified text and severity.
func throwNSAlert(messageText: String, severity: NSAlert.Style) {
    let alert: NSAlert = NSAlert()
    alert.alertStyle = severity
    alert.messageText = messageText
    alert.addButton(withTitle: "Ok")
    alert.runModal()
}

@discardableResult
/// Gets the hourly weather data for 2 days.
func getHourlyWeatherData(location: Location, save: DataSave) -> WeatherData {
    var weatherSave: [WeatherSaveInstance] = WeatherSave().twoDay
    if weatherSave.isEmpty { weatherSave = WeatherSave(true).twoDay }
    let url: String = constructURL(
        "https://api.openweathermap.org/data/2.5/onecall?",
        location.urlVersion
    )

    for save in weatherSave where save.url == url { return WeatherData(json: save.json) }

    guard let first = weatherSave.first else {
        fatalError("Weather Saves is empty.")
    }

    return WeatherData(json: first.json)
}

@discardableResult
/// Gets the 5 day weather data every 3 hours.
func getThreeHourWeatherData(location: Location, save: DataSave) -> [FiveDayWeatherHour] {
    var weatherSave: [WeatherSaveInstance] = WeatherSave().fiveDay
    if WeatherSave().fiveDay.isEmpty { weatherSave = WeatherSave(true).fiveDay }
    var hours: [FiveDayWeatherHour] = []
    let url: String = constructURL(
        "https://api.openweathermap.org/data/2.5/forecast?",
        location.urlVersion
    )

    for save in weatherSave where save.url == url {
        let json: JSON = save.json

        for index in 16...(json["list"].count - 1) {
            hours.append(FiveDayWeatherHour(json: json["list"][index]))
        }

        return hours
    }

    guard let first = weatherSave.first else {
        fatalError("Weather Saves is empty.")
    }

    for index in 16...(first.json["list"].count - 1) {
        hours.append(FiveDayWeatherHour(json: first.json["list"][index]))
    }

    return hours
}

//
//  MultipleDayLoading.swift
//  Weather
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
    return WeatherData(json: JSON(parseJSON: WeatherSave(dataSave: save).lastSaveJSON2Day))
}

@discardableResult
/// Gets the 5 day weather data every 3 hours.
func getThreeHourWeatherData(location: Location, save: DataSave) -> [FiveDayWeatherHour] {
    var hours: [FiveDayWeatherHour] = []
    let json: JSON = JSON(
        parseJSON: WeatherSave(dataSave: save).lastSaveJSON5Day
    )

    for index in 16...(json["list"].count - 1) {
        hours.append(FiveDayWeatherHour(json: json["list"][index]))
    }

    return hours
}

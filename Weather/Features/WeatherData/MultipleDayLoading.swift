//
//  MultipleDayLoading.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 18/04/23.
//

import Foundation
import SwiftUI
import AppKit
import CoreLocation
import SwiftyJSON

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
func getHourlyWeatherData(location: Location) -> WeatherData {
    let url: String = "https://api.openweathermap.org/data/2.5/onecall?"
    let latAndLon: String = location.urlVersion

    guard let URL = URL(string: constructURL(url, latAndLon)) else {
        throwNSAlert(messageText: "URL: \(constructURL(url, latAndLon)) does not exist.", severity: .critical)
        fatalError()
    }

    do {
        let contents: String = try String(contentsOf: URL, encoding: .ascii)

        return WeatherData(json: JSON(parseJSON: contents))
    } catch {
        throwNSAlert(messageText: "Failed to gather weather data", severity: .critical)
        fatalError()
    }
}

@discardableResult
/// Gets the 5 day weather data every 3 hours.
func getThreeHourWeatherData(location: Location, save: DataSave) -> [FiveDayWeatherHour] {
    var hours: [FiveDayWeatherHour] = []
    let json: JSON = JSON(
        parseJSON: WeatherSave(dataSave: save).lastSaveJSON
    )

    for index in 16...(json["list"].count - 1) {
        hours.append(FiveDayWeatherHour(json: json["list"][index]))
    }

    return hours
}

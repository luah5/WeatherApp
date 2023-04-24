//
//  MultipleDayLoading.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 18/04/23.
//

import Foundation
import SwiftUI
import SwiftyJSON

let baseURL: String = "https://api.openweathermap.org/data/2.5/onecall?"
let apiKey: String = "&appid=59b882df8e35c2c5eefe87e105b2d6df"
let location: String = "lat=51.49900424070662&lon=-0.25151805030659496"
let units: String = "&units=metric"
let exclude: String = "&exclude=minutely"

func constructURL(baseURL: String) -> String {
    return baseURL + location + apiKey + units + exclude
}

func throwNSAlert(messageText: String, severity: NSAlert.Style) {
    let alert = NSAlert()
    alert.alertStyle = severity
    alert.messageText = messageText
    alert.addButton(withTitle: "Ok")
    alert.runModal()

    if severity == .critical {
        fatalError(messageText)
    }
}

func getHourlyWeatherData() -> [WeatherHour] {
    var hours: [WeatherHour] = []
    let url = "https://api.openweathermap.org/data/2.5/onecall?"

    guard let myURL = URL(string: constructURL(baseURL: url)) else {
        throwNSAlert(messageText: "URL: \(constructURL(baseURL: url)) does not exist.", severity: .critical)
        fatalError()
    }

    do {
        let contents: Data = try String(contentsOf: myURL, encoding: .ascii).data(using: .ascii)!

        let json = try JSON(data: contents)

        hours.append(WeatherHour(json: json["current"]))

        for index in 0...(json["hourly"].count - 1) {
            hours.append(WeatherHour(json: json["hourly"][index]))
        }
    } catch {
        throwNSAlert(messageText: "Failed to gather weather data", severity: .critical)
    }

    return hours
}

func getThreeHourWeatherData() -> [WeatherHour] {
    var hours: [WeatherHour] = []
    let url = "https://api.openweathermap.org/data/2.5/forecast?"

    guard let myURL = URL(string: constructURL(baseURL: url)) else {
        throwNSAlert(messageText: "URL: \(constructURL(baseURL: url)) does not exist.", severity: .critical)
        fatalError()
    }

    do {
        let contents: Data = try String(contentsOf: myURL, encoding: .ascii).data(using: .ascii)!

        let json = try JSON(data: contents)

        hours.append(WeatherHour(json: json["list"]))

        for index in 16...(json["hourly"].count - 1) {
            hours.append(WeatherHour(json: json["hourly"][index]))
        }
    } catch {
        throwNSAlert(messageText: "Failed to gather weather data", severity: .critical)
    }

    return hours
}

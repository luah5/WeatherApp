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
let exclude: String = "&exclude=current,minutely"

func constructURL() -> String {
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

func multipleDays() -> [WeatherHour] {
    var hours: [WeatherHour] = []
    guard let myURL = URL(string: constructURL()) else {
        throwNSAlert(messageText: "URL: \(constructURL()) does not exist.", severity: .critical)
        fatalError("URL: \(constructURL()) does not exist.")
    }

    do {
        let contents: Data = try String(contentsOf: myURL, encoding: .ascii).data(using: .ascii)!

        let hourlyJSON = try JSON(data: contents)["hourly"]

        for index in 0...(hourlyJSON.count - 1) {
            hours.append(WeatherHour(json: hourlyJSON[index]))
        }
    } catch {
        throwNSAlert(messageText: "Failed to gather weather data", severity: .critical)
    }

    return hours
}

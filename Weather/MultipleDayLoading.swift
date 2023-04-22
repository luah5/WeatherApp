//
//  MultipleDayLoading.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 18/04/23.
//

import Foundation
import AppKit
import SwiftUI
import SwiftyJSON

let baseURL: String = "https://api.openweathermap.org/data/2.5/onecall?"
let apiKey: String = "&appid=59b882df8e35c2c5eefe87e105b2d6df"
let location: String = "lat=51.49900424070662&lon=-0.25151805030659496"
let units: String = "&units=metric"
let exclude: String = "&exclude=current,minutely"

func constructURL() -> String {
    let url = baseURL + location + apiKey + units + exclude

    return url
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

func multipleDays() {

    guard let myURL = URL(string: constructURL()) else {
        throwNSAlert(messageText: "URL: \(constructURL()) does not exist.", severity: .critical)
        fatalError("URL: \(constructURL()) does not exist.")
    }

    do {
        let contents: Data = try String(contentsOf: myURL, encoding: .ascii).data(using: .ascii)!

        let json = try JSON(data: contents)

        for index in 0...(json["hourly"].count - 1) {
            print(json["hourly"][index])
        }
    } catch {
        throwNSAlert(messageText: "Failed to gather weather data", severity: .critical)
    }
}


struct WeatherDescription {
    var mainDescription: String, description: String

    init(json: JSON) {
        self.mainDescription = String(describing: json["main"])
        self.description = String(describing: json["description"])
    }
}

// TODO: Implement the remaining fields
struct WeatherHour {
    var wind_gust: Float, pressure: Int, temp: Float, clouds: Int, dew_point: Float, visibility: Int
    var dt: Int, humidity: Int, feels_like: Float, uvi: Int, wind_deg: Int, wind_speed: Float, weather: WeatherDescription

    init(json: JSON) {
        wind_gust = Float(json["wind_gust"].stringValue) ?? -100
        pressure = Int(json["pressure"].stringValue) ?? -100
        temp = Float(json["temp"].stringValue) ?? -100
        clouds = Int(json["clouds"].stringValue) ?? -100
        dew_point = Float(json["dew_point"].stringValue) ?? -100
        visibility = Int(json["visibilty"].stringValue) ?? -100

        dt = Int(json["dt"].stringValue) ?? -100
        humidity = Int(json["humidity"].stringValue) ?? -100
        feels_like = Float(json["feels_like"].stringValue) ?? -100
        uvi = Int(json["uvi"].stringValue) ?? -100
        wind_deg = Int(json["wind_deg"].stringValue) ?? -100
        wind_speed = Float(json["wind_speed"].stringValue) ?? -100

        weather = WeatherDescription(json: json["weather"][0])
    }
}

struct WeatherDays {
    var weatherHours: [WeatherHour]
}

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
let units: String = "&units=metric"
let exclude: String = "&exclude=current,minutely"

func getLatitudeAndLongtitude() -> String {
    return "lat=51.49900424070662&lon=-0.25151805030659496"
}

func constructURL() -> String {
    let url = baseURL + getLatitudeAndLongtitude() + apiKey + units + exclude

    return url
}

func multipleDays() {

    guard let myURL = URL(string: constructURL()) else {
        fatalError("failed to get weather data")
    }

    do {
        let contents: Data = try String(contentsOf: myURL, encoding: .ascii).data(using: .ascii)!
        print(contents)
        // swiftlint:disable force_cast identifier_name superfluous_disable_command
        let json = try JSON(data: contents)
        for object in json["hourly"] {
            print("hourly object \n \n \n")

            let string = String(describing: object)

            let JSON = try getJsonObject(string: string)
            print(JSON)

            for object2 in try JSON {
                print(object2.1)
            }
        }
    } catch {
        fatalError("why is this failing??")
    }
}

struct WeatherHour {
    var dt: Int
    var tem: Float
    var feels_like: Float
    var pressure: Int
    var humidity: Int
    var dew_point: Float
    var uvi: Int
    var clouds: Float
    var visibility: Int
    var wind_speed: Float
    var wind_deg: Int
    var wind_gust: Float
}

struct WeatherDays {
    var weatherHours: [WeatherHour]
}

// swiftlint:enable force_cast identifier_name superfluous_disable_command

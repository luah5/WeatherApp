//
//  WeatherData.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 10/05/23.
//

import Foundation
import SwiftyJSON

struct WeatherData {
    var hours: [WeatherHour], minutes: [WeatherMinute], precipitationInNextHour: Bool

    init(json: JSON) {
        hours = []
        minutes = []

        hours.append(
            WeatherHour(
                json: json["current"],
                isConverted: false
            )
        )

        for index in 0...(json["hourly"].count - 1) {
            hours.append(
                WeatherHour(
                    json: json["hourly"][index],
                    isConverted: false
                )
            )
        }

        precipitationInNextHour = false
        for index in 0...(json["minutely"].count - 1) {
            minutes.append(
                WeatherMinute(
                    json: json["minutely"][index]
                )
            )

            if (Float(json["minutely"][index]["precipitation"].stringValue) ?? 0) > 1
                && precipitationInNextHour != true {
                precipitationInNextHour = true
            }
        }
    }
}

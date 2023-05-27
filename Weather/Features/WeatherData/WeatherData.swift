//
//  WeatherData.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 10/05/23.
//

import Foundation
import SwiftyJSON

/// A structure for handling weather data
struct WeatherData {
    var hours: [WeatherHour], minutes: [WeatherMinute], precipitationInNextHour: Bool, alerts: [WeatherAlert]
    var days: [WeatherDayDaily]
    var location: String, timezoneOffset: Int

    init(json: JSON) {
        precipitationInNextHour = false
        hours = []; minutes = []; alerts = []; days = []

        timezoneOffset = Int(json["timezone_offset"].stringValue) ?? 0
        location = String(
            json["timezone"]
                .stringValue.split(separator: "/")[1]
        )

        hours.append(
            WeatherHour(
                json: json["current"],
                isConverted: false
            )
        )

        if json["alerts"].exists() {
            for index in 0...(json["alerts"].count - 1) {
                alerts.append(
                    WeatherAlert(
                        json: json["alerts"][index]
                    )
                )
            }
        }

        for index in 0...(json["hourly"].count - 1) {
            hours.append(
                WeatherHour(
                    json: json["hourly"][index],
                    isConverted: false
                )
            )
        }

        for index in 0...4 {
            days.append(
                WeatherDayDaily(
                    json: json["daily"][index]
                )
            )
        }

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

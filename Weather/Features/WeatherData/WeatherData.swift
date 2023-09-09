//
//  WeatherData.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 10/05/23.
//

import Foundation

/// A structure for handling weather data
struct WeatherData: Identifiable, Hashable {
    static func == (lhs: WeatherData, rhs: WeatherData) -> Bool {
        lhs.id == rhs.id
    }

    let id: UUID = UUID()
    var hours: [WeatherHour], minutes: [WeatherMinute], precipitationInNextHour: Bool, alerts: [WeatherAlert]
    var days: [WeatherDayDaily]
    let location: String, timezoneOffset: Int

    init(json: JSON) {
        self.precipitationInNextHour = false
        self.hours = []; self.minutes = []; self.alerts = []; self.days = []

        self.timezoneOffset = Int(json["timezone_offset"].stringValue) ?? 0
        self.location = json["timezone"].stringValue.split(separator: "/")[1].toString()

        self.hours.append(
            WeatherHour(
                json: json["current"],
                isConverted: false,
                timezoneOffset: timezoneOffset
            )
        )

        if json["alerts"].exists() {
            for index in 0...(json["alerts"].count - 1) {
                self.alerts.append(
                    WeatherAlert(
                        json: json["alerts"][index]
                    )
                )
            }
        }

        for index in 0...(json["hourly"].count - 1) {
            self.hours.append(
                WeatherHour(
                    json: json["hourly"][index],
                    isConverted: false,
                    timezoneOffset: timezoneOffset
                )
            )
        }

        for index in 0...4 {
            self.days.append(
                WeatherDayDaily(
                    json: json["daily"][index]
                )
            )
        }

        if json["minutely"].exists() {
            for index in 0...(json["minutely"].count - 1) {
                self.minutes.append(
                    WeatherMinute(
                        json: json["minutely"][index]
                    )
                )

                if (Float(json["minutely"][index]["precipitation"].stringValue) ?? 0) > 1
                    && precipitationInNextHour != true {
                    precipitationInNextHour = true
                }
            }
        } else {

        }
    }
}

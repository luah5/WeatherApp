//
//  WeatherForecast.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 23/04/23.
//

import Foundation

/// A struct for getting the weather forecast [#10](https://github.com/luah5/WeatherApp/issues/10)
struct WeatherForecast {
    var current: WeatherHour, today: WeatherDay, tomorrow: WeatherDay, dayAfterTomorrow: WeatherDay

    init() {
        /// Get the weather data
        let weatherHours: [WeatherHour] = getHourlyWeatherData()

        var lastDay: Int = Int(weatherHours[1].time
            .toTimestamp()
            .split(separator: " ")[0])!
        var day: Int = 0

        var todayWeatherHours: [WeatherHour] = [], tomorrowWeatherHours: [WeatherHour] = []
        var dayAfterTomorrowWeatherHours: [WeatherHour] = []

        // For some reason swift will throw "Return from initializer without initializing all stored properties"
        // The following code is to fix it
        self.current = weatherHours[0]

        /// Loop through the weather hours (excluding the first one)
        for index in 1...weatherHours.count - 1 {
            let currentDay = Int(
                weatherHours[index].time.toTimestamp()
                    .split(separator: " ")[0])!

            if currentDay != lastDay {
                day += 1
                lastDay = currentDay
            }

            if day == 0 {
                todayWeatherHours.append(weatherHours[index])
            } else if day == 1 {
                tomorrowWeatherHours.append(weatherHours[index])
            } else {
                dayAfterTomorrowWeatherHours.append(weatherHours[index])
            }
        }

        /// Create the WeatherDay( ... ) objects
        self.today = WeatherDay(weatherHours: todayWeatherHours)
        self.tomorrow = WeatherDay(weatherHours: tomorrowWeatherHours)
        self.dayAfterTomorrow = WeatherDay(weatherHours: dayAfterTomorrowWeatherHours)
    }
}

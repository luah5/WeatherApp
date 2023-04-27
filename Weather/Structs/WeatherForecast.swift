//
//  WeatherForecast.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 23/04/23.
//

import Foundation

/// A struct for getting the weather forecast [#10](https://github.com/luah5/WeatherApp/issues/10)
struct WeatherForecast {
    var current: WeatherHour, today: WeatherDay, weatherDays: [WeatherDay]

    init() {
        /// Get the weather data
        var weatherHours: [WeatherHour] = getHourlyWeatherData()
        let fiveDayWeatherHours: [FiveDayWeatherHour] = getThreeHourWeatherData()

        for hour in fiveDayWeatherHours {
            weatherHours.append(toWeatherHour(fiveDayWeatherHour: hour))
        }

        var lastDay: Int = Int(weatherHours[1].time
            .toTimestamp()
            .split(separator: " ")[0])!
        var day: Int = 0

        var otherDayHours: [WeatherHour] = [], todayWeatherHours: [WeatherHour] = []

        // For some reason swift will throw "Return from initializer without initializing all stored properties"
        // The following code is to fix it
        self.current = weatherHours[0]
        weatherDays = []

        /// Loop through the weather hours (excluding the first one)
        for index in 1...weatherHours.count - 1 {
            let currentDay = Int(
                weatherHours[index].time.toTimestamp()
                    .split(separator: " ")[0])!

            if currentDay != lastDay {
                day += 1
                lastDay = currentDay
                if !(day == 0) {
                    weatherDays.append(WeatherDay(weatherHours: otherDayHours))
                }
                otherDayHours = []
            }

            if day == 0 {
                todayWeatherHours.append(weatherHours[index])
            } else {
                otherDayHours.append(weatherHours[index])
            }
        }

        /// Create the WeatherDay( ... ) object
        self.today = WeatherDay(weatherHours: todayWeatherHours)
    }
}

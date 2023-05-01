//
//  WeatherForecast.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 23/04/23.
//

import Foundation

/// A struct for getting the weather forecast see [#10](https://github.com/luah5/WeatherApp/issues/10)
struct WeatherForecast {
    var current: WeatherHour, today: WeatherDay, weatherDays: [WeatherDay]

    init() {
        /// Get the weather data
        var weatherHours: [WeatherHour] = getHourlyWeatherData()
        let fiveDayWeatherHours: [FiveDayWeatherHour] = getThreeHourWeatherData()

        /// Loops through the FiveDayWeatherHours and appends it to the weatherHours array by converting
        for hour in fiveDayWeatherHours {
            weatherHours.append(toWeatherHour(fiveDayWeatherHour: hour))
        }

        var lastDay: Int = Int(weatherHours[1].time
            .toTimestamp()
            .split(separator: " ")[0])!
        var day: Int = 0

        /// Intialize the WeatherHour arrays
        var otherDayHours: [WeatherHour] = [], todayWeatherHours: [WeatherHour] = []

        /// For some reason swift will throw "Return from initializer without initializing all stored properties"
        /// The following code is to fix it
        self.current = weatherHours[0]
        weatherDays = []

        /// Loop through the weather hours (excluding the first one)
        for index in 1...weatherHours.count - 1 {
            let currentDay: Int = Int(
                weatherHours[index].time.toTimestamp()
                    .split(separator: " ")[0])!

            if currentDay != lastDay {
                if !(day == 0) && !otherDayHours.isEmpty {
                    weatherDays.append(WeatherDay(weatherHours: otherDayHours))
                }
                day += 1
                lastDay = currentDay
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

//
//  WeatherForecast.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 23/04/23.
//

import Foundation

struct WeatherForecast {
    var today: WeatherDay, tomorrow: WeatherDay, dayAfterTomorrow: WeatherDay

    init() {
        /// Get the weather data
        let weatherHours: [WeatherHour] = getWeatherData()

        let lastDay: Int = Int(weatherHours[1].time
            .toTimestamp()
            .split(separator: " ")[0])!
        var day: Int = 0

        var todayWeatherHours: [WeatherHour] = [], tomorrowWeatherHours: [WeatherHour] = []
        var dayAfterTomorrowWeatherHours: [WeatherHour] = []

        // For some reason swift will throw "Return from initializer without initializing all stored properties"
        // The following code is to fix it
        self.today = WeatherDay(weatherHours: [])
        self.tomorrow = WeatherDay(weatherHours: [])
        self.dayAfterTomorrow = WeatherDay(weatherHours: [])

        for index in 1...weatherHours.count {

            let currentDay = Int(
                weatherHours[index].time.toTimestamp()
                    .split(separator: " ")[0])!

            if currentDay != lastDay {
                if day == 0 {
                    self.today = WeatherDay(weatherHours: todayWeatherHours)
                } else if day == 1 {
                    self.tomorrow = WeatherDay(weatherHours: tomorrowWeatherHours)
                } else if day == 2 {
                    self.dayAfterTomorrow = WeatherDay(weatherHours: dayAfterTomorrowWeatherHours)
                }
                day += 1
            }

            if day == 0 {
                todayWeatherHours.append(weatherHours[index])
            } else if day == 1 {
                tomorrowWeatherHours.append(weatherHours[index])
            } else {
                dayAfterTomorrowWeatherHours.append(weatherHours[index])
            }
        }
    }
}

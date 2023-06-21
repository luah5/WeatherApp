//
//  WeatherForecast.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 23/04/23.
//

import Foundation

/// A struct for getting the weather forecast see [#10](https://github.com/luah5/WeatherApp/issues/10)
struct WeatherForecast {
    var current: WeatherHour, today: WeatherDay, weatherDays: [WeatherDay], weatherMinutes: [WeatherMinute]
    var weatherData: WeatherData, precipitationInNext24H: Float, address: String

    init(coordinateLocation: Location, _ dataSave: DataSave) {
        /// Get the weather data
        weatherData = getHourlyWeatherData(location: coordinateLocation, save: dataSave)
        address = coordinateLocation.locationString; weatherMinutes = weatherData.minutes

        var weatherHours: [WeatherHour] = weatherData.hours
        var todayWeatherHours: [WeatherHour] = [], otherDayHours: [WeatherHour] = []

        let fiveDayWeatherHours: [FiveDayWeatherHour] = getThreeHourWeatherData(location: coordinateLocation,
            save: dataSave)

        /// Loops through the FiveDayWeatherHours and appends it to the weatherHours array by converting
        for hour in fiveDayWeatherHours {
            weatherHours.append(toWeatherHour(fiveDayWeatherHour: hour))
        }

        var lastDay: Int = Int(weatherHours[1].time
            .toTimestamp()
            .split(separator: " ").first!)!, day: Int = 0
        precipitationInNext24H = 0

        /// For some reason swift will throw "Return from initializer without initializing all stored properties"
        /// The following code is to fix it
        self.current = weatherHours.first!
        weatherDays = []

        /// Loop through the weather hours (excluding the first one)
        for index in 1...weatherHours.count - 1 {
            let currentHour = weatherHours[index]
            let currentDay: Int = Int(
                currentHour.time.toTimestamp()
                    .split(separator: " ").first!)!

            if currentDay != lastDay {
                if !(day == 0) && !otherDayHours.isEmpty {
                    weatherDays.append(
                        WeatherDay(
                            weatherHours: otherDayHours,
                            weatherDay: weatherData.days[safe: day] ?? .init(json: .null),
                            isConverted: currentHour.converted
                        )
                    )
                }

                day += 1
                lastDay = currentDay
                otherDayHours = []
            }

            if day == 0 {
                todayWeatherHours.append(weatherHours[index])
                precipitationInNext24H += Float(
                    currentHour.precipitation * Float(currentHour.chanceOfRain / 100)
                )
            } else {
                otherDayHours.append(weatherHours[index])
            }
        }

        /// Create the WeatherDay( ... ) object
        self.today = WeatherDay(
            weatherHours: todayWeatherHours,
            weatherDay: weatherData.days.first!,
            isConverted: false
        )
    }
}

//
//  WeatherDay.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 23/04/23.
//

import Foundation

/// A weather day with respective weather hours used by the WeatherForecast struct
struct WeatherDay {
    var weatherHours: [WeatherHour], minTemp: Float, maxTemp: Float

    init(weatherHours: [WeatherHour], isConverted: Bool) {
        self.weatherHours = weatherHours

        self.minTemp = weatherHours.first?.temp ?? -100
        self.maxTemp = weatherHours.first?.temp ?? -100

        for hour in weatherHours {
            if hour.temp > self.maxTemp {
                self.maxTemp = hour.temp
            }
            if hour.temp < self.minTemp {
                self.minTemp = hour.temp
            }
        }
    }
}

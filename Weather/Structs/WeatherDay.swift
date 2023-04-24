//
//  WeatherDay.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 23/04/23.
//

import Foundation

struct WeatherDay {
    var weatherHours: [WeatherHour], minTemp: Float, maxTemp: Float

    init(weatherHours: [WeatherHour]) {
        self.weatherHours = weatherHours

        self.minTemp = 100
        self.maxTemp = -100

        for hour in weatherHours {
            if hour.temp > self.maxTemp {
                self.maxTemp = hour.temp
            } else if hour.temp < self.minTemp {
                self.minTemp = hour.temp
            }
        }
    }
}

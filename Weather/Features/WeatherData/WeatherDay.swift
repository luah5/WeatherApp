//
//  WeatherDay.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 23/04/23.
//

import Foundation

/// A weather day with respective weather hours used by the WeatherForecast struct
struct WeatherDay {
    var weatherHours: [WeatherHour], minTemp: Float, maxTemp: Float, weatherDayDaily: WeatherDayDaily

    init(weatherHours: [WeatherHour], weatherDay: WeatherDayDaily, isConverted: Bool) {
        self.weatherHours = weatherHours

        self.weatherDayDaily = weatherDay
        self.minTemp = weatherDayDaily.temperatureDaily.min
        self.maxTemp = weatherDayDaily.temperatureDaily.max
    }
}

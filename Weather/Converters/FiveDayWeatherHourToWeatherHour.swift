//
//  FiveDayWeatherHourToWeatherHour.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 27/04/23.
//

import Foundation
import SwiftyJSON

func toWeatherHour(fiveDayWeatherHour: FiveDayWeatherHour) -> WeatherHour {
    let json = """
{
    "wind_gust": "\(fiveDayWeatherHour.windGust)",
    "wind_deg": "\(fiveDayWeatherHour.windDeg)",
    "wind_speed": "\(fiveDayWeatherHour.windSpeed)",
    "temp": "\(fiveDayWeatherHour.temp)",
    "clouds": "\(fiveDayWeatherHour.clouds)",
    "dt": "\(fiveDayWeatherHour.time)",
    "pressure": "\(fiveDayWeatherHour.pressure)",
    "dew_point": "8",
    "visibility": "\(fiveDayWeatherHour.visibility)",
    "humidity": "\(fiveDayWeatherHour.humidity)",
    "feels_like": "\(fiveDayWeatherHour.feelsLike)",
    "uvi": "12",
    "weather": [
        {
            "main": "\(fiveDayWeatherHour.mainDesc)",
            "description": "\(fiveDayWeatherHour.desc)",
            "icon": "\(fiveDayWeatherHour.icon)"
        }
    ],
    "clouds": "\(fiveDayWeatherHour.clouds)",
    "pop": "\(fiveDayWeatherHour.chanceOfRain)"
}
"""
    print(json)
    do {
        return try WeatherHour(json: JSON(data: json.data(using: .ascii)!))
    } catch {
        fatalError("Error getting weather data")
    }
}

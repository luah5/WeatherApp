//
//  FiveDayWeatherHourToWeatherHour.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 27/04/23.
//

import Foundation

func toWeatherHour(fiveDayWeatherHour: FiveDayWeatherHour) -> WeatherHour {
    var weatherHour: WeatherHour = WeatherHour(
        json: JSON(
            parseJSON: """
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
"pop": "\(fiveDayWeatherHour.chanceOfRain)"
}
"""
        ),
        isConverted: true
    )

    weatherHour.chanceOfRain = fiveDayWeatherHour.chanceOfRain
    weatherHour.precipitation = fiveDayWeatherHour.threeHourRain
    weatherHour.snowPrecipitation = fiveDayWeatherHour.threeHourSnow

    return weatherHour
}

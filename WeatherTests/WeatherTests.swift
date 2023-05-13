//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Raymond Vleeshouwer on 17/04/23.
//

import XCTest
@testable import Weather

final class WeatherTests: XCTestCase {
    func testWeatherForecastPerformance() throws {
        let location = Location(
            lat: 51.62,
            lon: -0.1
        )
        self.measure {
            /*
            let _: WeatherForecast = WeatherForecast(
                coordinateLocation: location
            )
            */

            getThreeHourWeatherData(location: location)
            getHourlyWeatherData(location: location)
        }
    }
}

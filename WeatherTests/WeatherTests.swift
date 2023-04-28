//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Raymond Vleeshouwer on 17/04/23.
//

import XCTest
@testable import Weather

final class WeatherTests: XCTestCase {
    func testPerformance() throws {
        self.measure {
            let data = getThreeHourWeatherData()
            let data1 = getHourlyWeatherData()
            print(data.count, data1.count)
        }
    }

}

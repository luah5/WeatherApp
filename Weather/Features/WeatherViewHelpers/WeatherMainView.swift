//
//  WeatherMainView.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 13/05/23.
//

import SwiftUI
import CoreLocation
import MapKit

/// The weather view that is shown in the main view
struct WeatherMainView: View {
    var coordLocation: Location
    var weatherForecast: WeatherForecast

    init(location: Location) {
        coordLocation = location

        weatherForecast = WeatherForecast(
            coordinateLocation: location
        )
    }

    var body: some View {
        Spacer()
        topView

        ScrollView(.vertical) {
            if !weatherForecast.weatherData.alerts.isEmpty {
                weatherAlerts
            }

            if weatherForecast.weatherData.precipitationInNextHour {
                VForm {
                    minutelyPrecipitation
                }
            }

            VForm {
                hourlyForecast
            }

            VForm {
                days
            }

            VForm {
                locationMap
            }

            weatherDetailViews
        }
    }
}

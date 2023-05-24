//
//  WeatherMainView.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 13/05/23.
//

import SwiftUI
import CoreLocation
import MapKit

struct WeatherMainView: View {
    var coordLocation: Location
    var weatherForecast: WeatherForecast

    init(location: Location) {
        coordLocation = location

        weatherForecast = WeatherForecast(
            coordinateLocation: location
        )
    }
    @State private var sheetIsPresented: Bool = false

    var body: some View {
        Spacer()
        topView

        Form {
            if !weatherForecast.weatherData.alerts.isEmpty {
                Section {
                    weatherAlerts
                }
            }

            if weatherForecast.weatherData.precipitationInNextHour {
                minutelyPrecipitation
            }

            Section {
                hourlyForecast
            }
            Section {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.secondary)
                    Text("4 DAY WEATHER")
                        .foregroundColor(.secondary)
                }

                days
            }
        }
        .formStyle(.grouped)

        weatherDetailViews
    }
}

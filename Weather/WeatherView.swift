//
//  ContentView.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 17/04/23.
//

import SwiftUI

/// The main view for looking at all the weather
struct WeatherView: View {
    let weatherForecast: WeatherForecast = .init()
    let timer = Timer.publish(
        every: 1,
        on: .main,
        in: .common
    ).autoconnect()
    @State private var reload: Bool = false

    var body: some View {
        NavigationSplitView {
            Text("Location")
        } detail: {
            Spacer()
            topView

            Form {
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
}

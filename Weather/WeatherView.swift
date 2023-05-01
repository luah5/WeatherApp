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

    var body: some View {
        NavigationSplitView {
            Text("Location")
        } detail: {
            Spacer()
            topView

            Form {
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

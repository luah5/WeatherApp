//
//  ContentView.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 17/04/23.
//

import SwiftUI

struct WeatherView: View {
    let weatherForecast: WeatherForecast = .init()

    /// The main view for looking at all the weather
    var body: some View {
        NavigationSplitView {
            Text("Location")
        } detail: {
            Spacer()
            topView
            Form {
                Section {
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.secondary)
                        Text("HOURLY FORECAST")
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Divider()
                        ForEach(weatherForecast.today.weatherHours, id: \.time) { hour in
                            HourItemView(weatherHour: hour)
                        }
                    }
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

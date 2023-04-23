//
//  ContentView.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 17/04/23.
//

import SwiftUI

struct WeatherView: View {
    let weatherForecast: [WeatherHour] = multipleDays()

    /// The main view for looking at all the weather
    var body: some View {
        NavigationSplitView {
            VStack {
                Text("My Location")
                    .fontWeight(.medium)
                    .padding([.top, .leading])
                Text(getTime())
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                Spacer()
                Text("\(weatherForecast[0].weather.mainDescription)")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
        } detail: {
            Button("hi") {
                print(multipleDays().count)
            }
            Spacer()
            VStack(spacing: 0) {
                Text(getCurrentCity())
                    .font(.system(.title))
                Text("\(Int(weatherForecast[0].temp))º")
                    .font(.system(size: 56, weight: .thin))
                Text("\(weatherForecast[0].weather.mainDescription)")
                    .font(.system(.headline, weight: .semibold))
                Text(getTime())
                    .font(.system(.headline, weight: .semibold))
                Text("Low: todoº High: todoº")
                    .font(.system(.headline, weight: .semibold))
            }
            Form {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.secondary)
                    Text("2 DAY WEATHER")
                        .foregroundColor(.secondary)
                }
                temperatureDetailView(day: "17th", weather: "Rain", minTemp: 8, maxTemp: 17)
                temperatureDetailView(day: "18th", weather: "Run", minTemp: 2, maxTemp: 13)
                temperatureDetailView(day: "19th", weather: "Sun", minTemp: 11, maxTemp: 18)
                temperatureDetailView(day: "20th", weather: "Sun", minTemp: 15, maxTemp: 19)
            }
            .formStyle(.grouped)

            HStack {
                feelsLike
                humidity
                visibility
            }
        }
    }
}

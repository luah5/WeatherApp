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
            Form {
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
        .formStyle(.grouped)
        } detail: {
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

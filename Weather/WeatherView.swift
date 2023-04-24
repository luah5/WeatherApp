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
            Form {
                Text("My Location")
                    .fontWeight(.medium)
                    .padding([.top, .leading])
                Text(getTime())
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                Spacer()
                Text("\(weatherForecast.current.weather.mainDescription)")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
        .formStyle(.grouped)
        } detail: {
            Spacer()
            VStack(spacing: 0) {
                Text(getCurrentCity())
                    .font(.system(.title))
                Text("\(Int(weatherForecast.current.temp))º")
                    .font(.system(size: 56, weight: .thin))
                Text("\(weatherForecast.current.weather.mainDescription)")
                    .font(.system(.headline, weight: .semibold))
                Text(getTime())
                    .font(.system(.headline, weight: .semibold))
                Text("Low: \(weatherForecast.today.minTemp.toInt())º High: \(weatherForecast.today.maxTemp.toInt())º")
                    .font(.system(.headline, weight: .semibold))
            }
            Form {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.secondary)
                    Text("HOURLY FORECAST")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Divider()
                    ForEach(weatherForecast.today.weatherHours, id: \.time) { hour in
                        let split = hour.time.toTimestamp().split(separator: " ")

                        VStack {
                            Text(split[split.count - 1])
                            hour.weather.icon
                            Text("\(hour.temp.toInt())º")
                        }
                        .frame(width: 45, height: 50)

                        Divider()
                    }
                }
            }
            .formStyle(.grouped)
            Form {
                VStack {
                    HStack {
                        Image(systemName: "humidity")
                            .foregroundColor(.secondary)
                        Text("HUMIDITY")
                            .foregroundColor(.secondary)
                            .font(.system(.caption2))
                    }
                    .padding(.leading)

                    Text("\(weatherForecast.current.humidity)%")
                        .font(.system(.title))
                        .padding(.leading)
                }
            }
            .formStyle(.grouped)
            Form {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.secondary)
                    Text("2 DAY WEATHER")
                        .foregroundColor(.secondary)
                }
                temperatureDetailView(day: weatherForecast.tomorrow)
                temperatureDetailView(day: weatherForecast.dayAfterTomorrow)
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

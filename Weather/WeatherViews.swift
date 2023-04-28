//
//  WeatherViews.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 23/04/23.
//

import SwiftUI

extension WeatherView {
    var topView: some View {
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
    }

    var humidity: some View {
        Form {
            HStack(spacing: 5) {
                Image(systemName: "humidity")
                    .controlSize(.small)
                    .foregroundColor(.secondary)
                Text("HUMIDITY")
                    .font(.system(.footnote))
                    .foregroundColor(.secondary)
            }

            Text("\(weatherForecast.current.humidity)%")
                .font(.system(.title))

            Text("The dew point is \(weatherForecast.current.dewPoint.toInt())º")
                .font(.system(.footnote))
        }
        .formStyle(.grouped)
        .frame(width: 200, height: 200)
    }

    var feelsLike: some View {
        Form {
            HStack(spacing: 5) {
                Image(systemName: "thermometer.medium")
                    .controlSize(.small)
                    .foregroundColor(.secondary)
                Text("FEELS LIKE")
                    .font(.system(.footnote))
                    .foregroundColor(.secondary)
            }
            Text("\(weatherForecast.current.feelsLike.toInt())º")
                .font(.system(.title))
        }
        .formStyle(.grouped)
        .frame(width: 200, height: 200)
    }

    var visibility: some View {
        Form {
            HStack(spacing: 5) {
                Image(systemName: "eye")
                    .controlSize(.small)
                    .foregroundColor(.secondary)
                Text("VISIBILITY")
                    .font(.system(.footnote))
                    .foregroundColor(.secondary)
            }
            Text("\(Int(weatherForecast.current.visibility / 1000)) km")
                .font(.system(.title))
        }
        .formStyle(.grouped)
        .frame(width: 200, height: 200)
    }

    var weatherDetailViews: some View {
        HStack {
            feelsLike
            humidity
            visibility
        }
    }

    @ViewBuilder
    var days: some View {
        ForEach(weatherForecast.weatherDays, id: \.minTemp) { day in
            let timestamp = day.weatherHours[1].time.toTimestamp().split(separator: " ")

            VStack {
                HStack(spacing: 30) {
                    Text(timestamp[0] + Int(timestamp[0])!.getProperDateWord())
                        .font(.system(size: 14, weight: .semibold))

                    day.weatherHours[Int(day.weatherHours.count / 2)].weather.icon.image
                        .foregroundColor(day.weatherHours[Int(day.weatherHours.count / 2)].weather.icon.color)

                    Text("\(day.minTemp.toInt())º")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.secondary)

                    HStack(spacing: 0) {
                        PreviewColor(.gray, width: 60)
                        PreviewColor(.yellow, width: 10)
                        PreviewColor(.blue, width: 10)
                        PreviewColor(.white, width: 10)
                        PreviewColor(.yellow, width: 10)
                    }
                    .clipShape(Capsule())
                    .overlay {
                        Capsule()
                            .stroke(Color(.white).opacity(0.15), lineWidth: 0.5)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }

                    Text("\(day.maxTemp.toInt())º")
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.trailing)
                        .frame(alignment: .trailing)

                }
                .frame(alignment: .center)

                ScrollView(.horizontal) {
                    HStack {
                        Divider()

                        ForEach(day.weatherHours, id: \.time) { hour in
                            HourItemView(weatherHour: hour)
                        }
                    }
                    .frame(alignment: .center)
                }
                .frame(height: 50)
            }
        }
    }
}

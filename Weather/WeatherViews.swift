//
//  WeatherViews.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 23/04/23.
//

import SwiftUI

extension WeatherView {
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
}

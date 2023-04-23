//
//  WeatherViews.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 23/04/23.
//

import SwiftUI

extension WeatherView {
    func createFormIcon(systemName: String, text: String) -> some View {
        HStack(spacing: 2) {
            Image(systemName: systemName)
                .foregroundColor(.secondary)
            Text("\(text)")
                .foregroundColor(.secondary)
                .font(.system(size: 8))
        }
    }

    var humidity: some View {
        VStack {
            createFormIcon(systemName: "humidity", text: "HUMIDITY")

            Text("\(weatherForecast[0].humidity)%")
                .font(.system(.largeTitle))

            Text("The dew point is \(weatherForecast[0].dewPoint.toInt())º right now.")
                .padding(.bottom)
        }
        .frame(width: 100, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .border(.black)
    }

    var feelsLike: some View {
        VStack {
            createFormIcon(systemName: "thermometer.medium", text: "FEELS LIKE")
                .padding([.top, .leading])

            Text("\(weatherForecast[0].feelsLike.toInt())º")
                .padding(.leading)
                .font(.system(.largeTitle))

            Text("")
                .padding([.bottom, .leading])
        }
        .frame(width: 100, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .border(.black)
    }

    var visibility: some View {
        VStack {
            createFormIcon(systemName: "eye.fill", text: "VISIBILITY")
                .padding([.top, .leading])

            Text("\(weatherForecast[0].visibility) km")
                .padding(.leading)
                .font(.system(.largeTitle))
        }
        .frame(width: 100, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .border(.secondary)
    }
}

//
//  HourItemView.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 26/04/23.
//

import SwiftUI

/// This view is for showing the hours of every WeatherDay
struct HourItemView: View {
    var hour: WeatherHour
    var isFirst: Bool

    @State
    private var presented: Bool = false

    init(weatherHour: WeatherHour, first: Bool) {
        hour = weatherHour
        isFirst = first
    }

    var body: some View {
        let split: [String.SubSequence] = hour.time.toTimestamp().split(separator: " ")

        Divider()
        VStack {
            Text(split[split.count - 1])
                .padding(.top)
            hour.weather.icon.image
                // .foregroundColor(hour.weather.icon.color)
                .scaledToFit()
                .frame(width: 10, height: 10)

            Spacer()

            if hour.chanceOfRain >= 10 {
                Text("\(hour.chanceOfRain)%")
                    .foregroundColor(.blue)
                    .padding(.bottom)
                    .bold()
            } else {
                Text("\(hour.temp.toInt())º")
                    .padding(.bottom)
            }
        }
        .onHover(perform: {hovering in
            presented = hovering
        })
        .popover(isPresented: $presented) {
            Form {
                Text("\(hour.weather.description.capitalized)")
                Text("Air pressure: **\(hour.pressure)**")
                Text("Humidity: **\(hour.humidity)%**")
                Text("Visibility: **\(hour.visibility) km**")
                Text("Feels Like: **\(hour.feelsLike.toInt())º**")
                Text("Cloud coverage: **\(hour.clouds)%**")

                if hour.converted {
                    Text("3 hour precipitation: **\(hour.precipitation.removeZeros()) mm**")
                    Text("1 hour precipitation: **\((hour.precipitation / 3).removeZeros()) mm**")
                } else {
                    Text("Precipitation: **\(hour.precipitation.removeZeros()) mm**")
                }

                if hour.chanceOfRain < 10 {
                    Text("Chance of rain: **\(hour.chanceOfRain)%**")
                }
            }
            .frame(width: 250, height: 300)
            .formStyle(.grouped)
        }
        .frame(width: 50, height: 60)
    }
}

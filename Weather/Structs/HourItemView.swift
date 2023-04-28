//
//  HourItemView.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 26/04/23.
//

import SwiftUI

struct HourItemView: View {
    var hour: WeatherHour

    @State
    private var presented: Bool = false

    init(weatherHour: WeatherHour) {
        hour = weatherHour
    }

    var body: some View {
        let split: [String.SubSequence] = hour.time.toTimestamp().split(separator: " ")

        VStack {
            Text(split[split.count - 1])
                .padding(.top)
            hour.weather.icon.image
                .foregroundColor(hour.weather.icon.color)
            Spacer()
            if hour.chanceOfRain >= 10 {
                Text("\(hour.chanceOfRain)%")
                    .foregroundColor(.blue)
                    .padding(.bottom)
            } else {
                Text("\(hour.temp.toInt())º")
                    .padding(.bottom)
            }
        }
        .onHover(perform: {_ in
            presented.toggle()
        })
        .popover(isPresented: $presented) {
            Form {
                Text("Air pressure: **\(hour.pressure)**")
                Text("Humidity: **\(hour.humidity)%**")
                Text("Visibility: **\(hour.visibility) km**")
                Text("Feels Like: **\(hour.feelsLike.toInt())º**")
                Text("Cloud coverage: **\(hour.clouds)%**")
                Text("Precipitation: **\(hour.precipitation.removeZeros()) mm**")
                Text("Chance of rain: **\(hour.chanceOfRain)%**")
            }
            .frame(width: 250, height: 300)
            .formStyle(.grouped)
        }
        .frame(width: 50, height: 60)
        Divider()
    }
}

//
//  HourItemView.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 26/04/23.
//

import SwiftUI

struct HourItemView: View {
    var hour: WeatherHour
    init(weatherHour: WeatherHour) {
        hour = weatherHour
        let split = hour.time.toTimestamp().split(separator: " ")
    }

    @State
    private var presented: Bool = false

    var body: some View {
        let split = hour.time.toTimestamp().split(separator: " ")
        VStack {
            Text(split[split.count - 1])
                .padding(.top)
            hour.weather.icon.image
                .foregroundColor(hour.weather.icon.color)
            Text("\(hour.temp.toInt())º")
                .padding(.bottom)
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
        .frame(width: 45, height: 50)
        Divider()
    }
}

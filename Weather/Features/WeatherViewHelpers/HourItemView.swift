//
//  HourItemView.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 26/04/23.
//

import SwiftUI

/// This view is for showing the hours of every WeatherDay
struct HourItemView: View {
    var hour: WeatherHour
    @State private var presented: Bool = false

    init(weatherHour: WeatherHour) {
        hour = weatherHour
    }

    var body: some View {
        let split: [String.SubSequence] = hour.time.toTimestamp().split(separator: " ")

        Button {
            presented.toggle()
        } label: {
            ZStack {
                Rectangle()
                    .frame(width: 50, height: 80)
                    .opacity(0.00000000000000001)
                VStack {
                    Text(split[split.count - 1])
                        .padding(.top)
                    hour.weather.icon.image
                        .scaledToFill()
                        .controlSize(.large)
                        .frame(width: 30, height: 30)

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
            }
        }
        .buttonStyle(.plain)
        .popover(isPresented: $presented) {
            Form {
                Group {
                    Text("\(hour.weather.description.capitalized)")
                    Text("Air pressure: **\(hour.pressure)**")
                    Text("Humidity: **\(hour.humidity)%**")
                    Text("Visibility: **\(hour.visibility) km**")
                    Text("Feels Like: **\(hour.feelsLike.toInt())º**")
                    Text("Cloud coverage: **\(hour.clouds)%**")
                    Text("""
Wind speed: **\(hour.windSpeed.removeZeros()) km/h**
""")
                    Text("""
Wind gust: **\(hour.windGust.removeZeros()) km/h**
""")
                }
                Group {
                    if hour.chanceOfRain < 10 && hour.chanceOfRain != 0 {
                        Text("Chance of rain: **\(hour.chanceOfRain)%**")
                    }

                    if hour.converted && hour.precipitation != 0 {
                        Text("3 hour precipitation: **\(hour.precipitation.removeZeros()) mm**")
                        Text("1 hour precipitation: **\((hour.precipitation / 3).removeZeros()) mm**")
                    } else if hour.precipitation != 0 {
                        Text("Precipitation: **\(hour.precipitation.removeZeros()) mm**")
                    }

                    if hour.snowPrecipitation > 0 {
                        Text("Snow: **\(hour.snowPrecipitation.removeZeros()) mm**")
                    }
                }
            }
            .formStyle(.grouped)
            .frame(width: 200, height: 300)
        }
        .frame(width: 50, height: 80)
    }
}

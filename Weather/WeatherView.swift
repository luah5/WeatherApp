//
//  ContentView.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 17/04/23.
//

import SwiftUI

struct WeatherView: View {
    // swiftlint:disable force_cast
    private var weatherData: WeatherData = getWeatherData() as! WeatherData

    /// The main view for looking at all the weather
    var body: some View {
        NavigationSplitView {
            Form {
                Form {
                    VStack {
                        Text("My Location")
                            .fontWeight(.medium)
                            .padding([.top, .leading])
                        Text(getTime())
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(weatherData.description)")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                }
                .border(.black)
            }
            .formStyle(.grouped)
        } detail: {
            Spacer()
            VStack(spacing: 0) {
                Text(getCurrentCity())
                    .font(.system(.title))
                Text("\(weatherData.temp)º")
                    .font(.system(size: 56, weight: .thin))
                Text("\(weatherData.description)")
                    .font(.system(.headline, weight: .semibold))
                Text(getTime())
                    .font(.system(.headline, weight: .semibold))
                Text("Low: \(weatherData.minTemp)º High: \(weatherData.maxTemp)º")
                    .font(.system(.headline, weight: .semibold))
            }
            Form {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.secondary)
                    Text("4 DAY WEATHER")
                        .foregroundColor(.secondary)
                }
                temperatureDetailView(day: "17th", weather: "Rain", minTemp: 8, maxTemp: 17)
                temperatureDetailView(day: "18th", weather: "Run", minTemp: 2, maxTemp: 13)
                temperatureDetailView(day: "19th", weather: "Sun", minTemp: 11, maxTemp: 18)
                temperatureDetailView(day: "20th", weather: "Sun", minTemp: 15, maxTemp: 19)
            }
            .formStyle(.grouped)
            .background(.opacity(0.2))
            Form {
                HStack {
                    Image(systemName: "humidity.fill")
                        .foregroundColor(.blue)
                        .font(.system(.headline))
                    Text("Humidity \(weatherData.humidity)%")
                        .font(.system(.headline, weight: .semibold))
                }
                HStack {
                    if weatherData.feelsLike > 27 {
                        Image(systemName: "thermometer.high")
                            .foregroundColor(.red)
                    } else if weatherData.feelsLike > 5 {
                        Image(systemName: "thermometer.medium")
                            .foregroundColor(.orange)
                    } else {
                        Image(systemName: "thermometer.low")
                            .foregroundColor(.blue)
                    }
                    Text("Feels like \(weatherData.feelsLike)º")
                        .font(.system(.headline, weight: .semibold))
                }
                HStack {
                    Image(systemName: "barometer")
                        .foregroundColor(.gray)
                    Text("Air pressure: \(weatherData.pressure)ATM")
                        .font(.system(.headline, weight: .semibold))
                }
            }
            .formStyle(.grouped)
            .background(.opacity(0.2))
        }
        .navigationSplitViewStyle(.prominentDetail)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
// swiftlint:enable force_cast

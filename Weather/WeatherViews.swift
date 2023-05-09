//
//  WeatherViews.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 23/04/23.
//

import SwiftUI

/// Extends WeatherView and adds the main body
extension WeatherView {
    var topView: some View {
        VStack(spacing: 0) {
            AddCityView()
                .padding(.trailing)
                .help("Add city, town or village.")

            Text(getCurrentCity())
                .font(.system(.title))
            Text("\(Int(weatherForecast.current.temp))º")
                .font(.system(size: 56, weight: .thin))
            Text("\(weatherForecast.current.weather.mainDescription)")
                .font(.system(.headline, weight: .semibold))

            Text(getTime())
                .font(.system(.headline, weight: .semibold))
                .help("The time the data was taken.")

            Text("Low: \(weatherForecast.today.minTemp.toInt())º High: \(weatherForecast.today.maxTemp.toInt())º")
                .font(.system(.headline, weight: .semibold))
                .help("The low and high temperature for today.")
        }
    }

    var humidity: some View {
        VStack {
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
        }
    }

    @ViewBuilder
    var hourlyForecast: some View {
        HStack {
            Image(systemName: "calendar")
                .foregroundColor(.secondary)
            Text("HOURLY FORECAST")
                .foregroundColor(.secondary)
        }
        HStack {
            ForEach(weatherForecast.today.weatherHours, id: \.time) { hour in
                HourItemView(weatherHour: hour, first: false)
            }
        }
    }

    var feelsLike: some View {
        VStack {
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
        }
    }

    var visibility: some View {
        VStack {
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
        }
    }

    var uvi: some View {
        VStack {
            Form {
                HStack(spacing: 5) {
                    Image(systemName: "sun.max.fill")
                        .controlSize(.small)
                        .foregroundColor(.secondary)
                    Text("UV INDEX")
                        .font(.system(.footnote))
                        .foregroundColor(.secondary)
                }
                VStack {
                    Text("\(weatherForecast.current.uvi)")
                        .font(.system(.title))
                        .padding(.trailing)

                    if weatherForecast.current.uvi < 5 {
                        Text("Low")
                            .font(.system(.title2))
                    } else if weatherForecast.current.uvi >= 4 {
                        Text("Moderate")
                            .font(.system(.title2))
                    } else if weatherForecast.current.uvi >= 7 {
                        Text("High")
                            .font(.system(.title2))
                    } else if weatherForecast.current.uvi >= 10 {
                        Text("Extreme")
                            .font(.system(.title2))
                    }
                }

                GeometryReader { geometry in
                    ZStack {
                        LinearGradient(
                            gradient: Gradient(colors: [.green, .yellow, .red, .purple]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .cornerRadius(5)
                        Circle()
                            .fill(Color.white)
                            .frame(width: 20, height: geometry.size.height)
                            .offset(
                                x: self.markerOffset(
                                    for: CGFloat(weatherForecast.current.uvi) + 0.5,
                                    in: geometry.size.width
                                )
                            )
                    }
                }
                .frame(width: 200, height: 5)
            }
            .formStyle(.grouped)
        }
    }

    private func markerOffset(for value: CGFloat, in width: CGFloat) -> CGFloat {
        let markerPosition = (value - 8) / 15
        return markerPosition * width
    }

    private func markerOffset2(for value: CGFloat, in width: CGFloat) -> CGFloat {
        let markerPosition = (value - 20) / 60
        return markerPosition * width
    }

    var sunPosition: some View {
        Form {
            VStack {
                ZStack {
                    SineLine()
                        .stroke(lineWidth: 2)
                        .foregroundColor(.secondary)
                        .frame(width: 300, height: 200)

                    Image(systemName: "sun.max.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .offset(x: 20, y: -40)
                        .foregroundColor(.yellow)
                }
            }
        }
        .formStyle(.grouped)
    }

    var weatherDetailViews: some View {
        HStack(spacing: 10) {
            feelsLike
                .help("Shows what the current temperature feels like.")
            humidity
                .help("Shows the current humidity.")
            visibility
                .help("Shows the current visibility (in km).")
            uvi
                .help("A gradient that shows the UV Index for this hour.")
        }
    }

    @ViewBuilder
    var days: some View {
        ForEach(weatherForecast.weatherDays, id: \.minTemp) { day in
            VStack {
                dayInfo(
                    day: day,
                    timestamp: day.weatherHours[1].time.toTimestamp()
                        .split(separator: " ")
                )

                ScrollView(.horizontal) {
                    HStack {
                        ForEach(day.weatherHours, id: \.time) { hour in
                            HourItemView(weatherHour: hour, first: false)
                        }
                    }
                    .frame(alignment: .center)
                }
            }
        }
    }

    @ViewBuilder
    func tempView(day: WeatherDay) -> some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(
                    gradient: Gradient(
                        colors: [.blue, .green, .yellow, .orange, .red]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .cornerRadius(5)

                Capsule()
                    .fill(Color.white)
                    .offset(
                        x: self.markerOffset2(
                            for: CGFloat(day.minTemp),
                            in: geometry.size.width
                        )
                    )
                    .frame(
                        width: CGFloat(day.maxTemp - day.minTemp) * 2,
                        height: 5
                    )
                    .opacity(0.9)
            }
        }
        .frame(width: 200, height: 5)
        .help("A gradient that shows the temperature.")
    }

    @ViewBuilder
    func dayInfo(day: WeatherDay, timestamp: [String.SubSequence]) -> some View {
        HStack(spacing: 30) {
            Text(timestamp[0] + Int(timestamp[0])!.getProperDateWord())
                .font(.system(size: 14, weight: .semibold))
                .help("The day of the forecast.")

            day.weatherHours[Int(day.weatherHours.count / 2)].weather.icon.image

            if day.weatherHours[
                Int(day.weatherHours.count) / 2
            ].chanceOfRain >= 10 {
                Text("""
\(String(
describing: day.weatherHours[
    Int(day.weatherHours.count) / 2
].chanceOfRain
))%
"""
                )
                .foregroundColor(.blue)
                .bold()
            }

            Text("\(day.minTemp.toInt())º")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)

            tempView(day: day)

            Text("\(day.maxTemp.toInt())º")
                .font(.system(size: 14, weight: .semibold))
                .padding(.trailing)
                .frame(alignment: .trailing)

        }
        .frame(alignment: .center)
    }
}

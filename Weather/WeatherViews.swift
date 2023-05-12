//
//  WeatherViews.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 23/04/23.
//

import SwiftUI
import CoreLocation
import MapKit

/// Extends WeatherView and adds the main body
extension WeatherView {
    // MARK: - Views
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
                .help("The time the data was taken.")

            Text("Low: \(weatherForecast.today.minTemp.toInt())º High: \(weatherForecast.today.maxTemp.toInt())º")
                .font(.system(.headline, weight: .semibold))
                .help("The low and high temperature for today.")
        }
    }

    @ViewBuilder
    var minutelyPrecipitation: some View {
        Form {
            Text("Rain forecast")
                .font(.system(.title2))

            Text("")

            HStack {
                ForEach(weatherForecast.weatherMinutes, id: \.time) { minute in
                    VStack {
                        GeometryReader { _ in
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, .blue, .white]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                            .cornerRadius(5)
                        }
                        .frame(width: 5, height: CGFloat(minute.precipitation * 250))
                    }
                }
            }
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

    @ViewBuilder
    var days: some View {
        ForEach(weatherForecast.weatherDays, id: \.minTemp) { day in
            VStack {
                dayInfo(
                    day: day,
                    timestamp: day.weatherHours[1].time.toTimestamp2()
                        .split(separator: ",")
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

    var weatherAlerts: some View {
        ForEach(weatherForecast.weatherData.alerts, id: \.description) { alert in
            Form {
                Group {
                    HStack(spacing: 5) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.red)
                            .frame(width: 50, height: 50)
                        Text("**Severe weather: \(alert.event)**")
                            .font(.system(.title))
                    }

                    Text("""
Starting: \(alert.startTime.toTimestamp2())
Ending: \(alert.endTime.toTimestamp2())
\(alert.description)
""")
                    Text("Alert from \(alert.senderName)")
                        .font(.system(.footnote))
                }
            }
            .formStyle(.grouped)
        }
    }

    // MARK: - Function Views
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
            Text(timestamp[0])
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

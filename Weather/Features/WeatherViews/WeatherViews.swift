//
//  WeatherViews.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 23/04/23.
//

import SwiftUI
import CoreLocation
import MapKit

/// Extends WeatherView and adds the main body
extension WeatherMainView {
    // MARK: - Views
    var topView: some View {
        VStack(spacing: 0) {
            Text(weatherForecast.address)
                .font(.system(.title))
            Text("\(weatherForecast.current.temp.toInt())º")
                .font(.system(size: 56, weight: .thin))
            Text("\(weatherForecast.current.weather.mainDescription)")
                .font(.system(.headline, weight: .semibold))

            Text("\(weatherForecast.current.time.toTimestamp3())")
                .font(.system(.headline, weight: .semibold))
                .help("The time the data was taken.")

            Text("Low: \(weatherForecast.today.minTemp.toInt())º High: \(weatherForecast.today.maxTemp.toInt())º")
                .font(.system(.headline, weight: .semibold))
                .help("The low and high temperature for today.")
        }
    }

    @ViewBuilder
    var minutelyPrecipitation: some View {
        VForm {
            Text("Rain forecast")
                .font(.system(.title2))

            Text("")

            HStack {
                ForEach(weatherForecast.weatherMinutes) { minute in
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
        HStack(spacing: 5) {
            Image(systemName: "clock")
                .foregroundColor(.secondary)
            Text("HOURLY FORECAST")
                .foregroundColor(.secondary)
        }

        HStack {
            ForEach(weatherForecast.today.weatherHours) { hour in
                HourItemView(weatherHour: hour)
            }
        }
    }

    @ViewBuilder
    var days: some View {
        HStack(spacing: 5) {
            Image(systemName: "calendar")
                .foregroundColor(.secondary)
            Text("4-DAY FORECAST")
                .foregroundColor(.secondary)
        }
        ForEach(weatherForecast.weatherDays) { day in
            VStack {
                dayInfo(
                    day: day,
                    timestamp: day.weatherHours[1].time.toTimestamp4()
                )

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(day.weatherHours) { hour in
                            HourItemView(weatherHour: hour)
                        }
                    }
                }
            }
        }
    }

    var weatherAlerts: some View {
        ForEach(weatherForecast.weatherData.alerts) { alert in
            VForm {
                Group {
                    HStack(spacing: 5) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.red)
                            .frame(width: 50, height: 50)
                        Text("**\(alert.event)**")
                            .font(.system(.title))
                    }

                    Text("""
Starting: \(alert.startTime.toTimestamp2())
Ending: \(alert.endTime.toTimestamp2())
""")
                    Text(alert.description)

                    Text("\(alert.senderName)")
                        .font(.system(.footnote))
                        .foregroundColor(.secondary)
                }
            }
        }
    }

    // MARK: - Function Views
    @ViewBuilder
    private func tempView(day: WeatherDay) -> some View {
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
                    .opacity(0.8)
            }
        }
        .frame(width: 200, height: 5)
        .help("A gradient that shows the temperature.")
    }

    @ViewBuilder
    private func dayInfo(day: WeatherDay, timestamp: String) -> some View {
        HStack(spacing: 30) {
            Text(timestamp)
                .font(.system(size: 14, weight: .semibold))
                .help("The day of the forecast.")

            day.weatherHours[Int(day.weatherHours.count / 2)].weather.icon.image
                .scaledToFill()
                .controlSize(.large)
                .frame(width: 25, height: 25)

            if day.weatherHours[
                Int(day.weatherHours.count) / 2
            ].chanceOfRain >= 10 {
                Text("""
\(day.weatherHours[Int(day.weatherHours.count) / 2].chanceOfRain.toString())%
""")
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

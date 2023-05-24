//
//  WeatherDetailViews.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 12/05/23.
//

import SwiftUI

extension WeatherMainView {
    // MARK: - Marker offsets
    private func markerOffset(for value: CGFloat, in width: CGFloat) -> CGFloat {
        let markerPosition = (value - 8) / 15
        return markerPosition * width
    }

    private func markerOffset2(for value: CGFloat, in width: CGFloat) -> CGFloat {
        let markerPosition = (value - 20) / 60
        return markerPosition * width
    }

    // MARK: - Humidity View
    private var humidity: some View {
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

    // MARK: - Feels Like View
    private var feelsLike: some View {
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

    // MARK: - Visibility View
    private var visibility: some View {
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
                Text("\(weatherForecast.current.visibility) km")
                    .font(.system(.title))
            }
            .formStyle(.grouped)
        }
    }

    // MARK: - UV Index View
    private var uvi: some View {
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

    // MARK: - Sun Position View
    private var sunPosition: some View {
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

    // MARK: - Rainfall View
    private var rainfall: some View {
        Form {
            HStack(spacing: 5) {
                Image(systemName: "drop.fill")
                    .controlSize(.small)
                    .foregroundColor(.secondary)
                Text("RAINFALL")
                    .font(.system(.footnote))
                    .foregroundColor(.secondary)
            }

            Text("""
\(weatherForecast.current.precipitation.removeZeros()) mm in the next hour
""")
            .font(.system(.title2))

            Text("""
\(weatherForecast.precipitationInNext24H.removeZeros()) mm expected in the next 24h
""")
            .font(.system(.footnote))
        }
        .formStyle(.grouped)
    }

    // MARK: - Moon Phase View
    private var moonPhase: some View {
        Form {
            HStack(spacing: 5) {
                Image(systemName: "moon.fill")
                    .foregroundColor(.secondary)

                Text("MOON PHASE")
                    .font(.system(.footnote))
                    .foregroundColor(.secondary)
            }

            Text(weatherForecast.current.moonPhase.rawValue)
                .font(.system(.title2))

            if weatherForecast.current.moonPhase == .new {
                Image(systemName: "moonphase.new.moon")
                    .resizable()
                    .scaledToFit()
                    .imageScale(.small)
                    .frame(width: 50, height: 50, alignment: .center)
            } else if weatherForecast.current.moonPhase == .waxingCrescent {
                Image(systemName: "moonphase.waxing.crescent")
                    .resizable()
                    .scaledToFit()
                    .imageScale(.small)
                    .frame(width: 50, height: 50, alignment: .center)
            } else if weatherForecast.current.moonPhase == .firstQuarter {
                Image(systemName: "moonphase.first.quarter")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50, alignment: .center)
            } else if weatherForecast.current.moonPhase == .waxingGibous {
                Image(systemName: "moonphase.waxing.gibbous")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50, alignment: .center)
            } else if weatherForecast.current.moonPhase == .full {
                Image(systemName: "moonphase.full.moon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50, alignment: .center)
            } else if weatherForecast.current.moonPhase == .waningGibous {
                Image(systemName: "moonphase.waning.gibbous")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50, alignment: .center)
            } else if weatherForecast.current.moonPhase == .lastQuarter {
                Image(systemName: "moonphase.last.quarter")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50, alignment: .center)
            } else if weatherForecast.current.moonPhase == .waningCrescent {
                Image(systemName: "moonphase.waning.crescent")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50, alignment: .center)
            }

            if weatherForecast.current.clouds >= 75 {
                Text("The moon is currently obscured due to high cloud coverage.")
                    .font(.system(.footnote))
            }
        }
        .formStyle(.grouped)
    }

    // MARK: - The weather detail Views
    @ViewBuilder
    private var weatherDetailViews: some View {
        VStack {
            HStack(spacing: 10) {
                feelsLike
                    .help("Shows what the current temperature feels like.")
                humidity
                    .help("Shows the current humidity.")
                visibility
                    .help("Shows the current visibility (in km).")
                uvi
                    .help("A gradient that shows the UV Index for this hour.")
                if weatherForecast.current.precipitation != 0 {
                    rainfall
                        .help("Shows the rainfall.")
                }

                moonPhase
            }

            Text("Weather for \(weatherForecast.address)")
                .font(.system(.footnote))
        }
    }
}

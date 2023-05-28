//
//  WeatherDetailViews.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 12/05/23.
//

import SwiftUI
import CoreLocation
import MapKit

extension WeatherMainView {
    // MARK: - Marker offsets
    func markerOffset(for value: CGFloat, in width: CGFloat) -> CGFloat {
        let markerPosition = (value - 8) / 15
        return markerPosition * width
    }

    func markerOffset2(for value: CGFloat, in width: CGFloat) -> CGFloat {
        let markerPosition = (value - 20) / 60
        return markerPosition * width
    }

    // MARK: - Humidity View
    var humidity: some View {
        VStack {
            VForm {
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

                Spacer()
            }
            .frame(height: height)
        }
    }

    // MARK: - Feels Like View
    var feelsLike: some View {
        VStack {
            VForm {
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

                Spacer()
            }
            .frame(height: height)
        }
    }

    // MARK: - Visibility View
    var visibility: some View {
        VStack {
            VForm {
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

                Spacer()
            }
            .frame(height: height)
        }
    }

    // MARK: - UV Index View
    var uvi: some View {
        VStack {
            VForm {
                HStack(spacing: 5) {
                    Image(systemName: "sun.max.fill")
                        .controlSize(.small)
                        .foregroundColor(.secondary)
                    Text("UV INDEX")
                        .font(.system(.footnote))
                        .foregroundColor(.secondary)
                }
                VStack(alignment: .leading) {
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
                Spacer()
            }
            .frame(height: height)
        }
    }

    // MARK: - Sun Position View
    var sunPosition: some View {
        VForm {
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
    }

    // MARK: - Rainfall View
    var rainfall: some View {
        VStack {
            VForm {
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
        }
    }

    // MARK: - Moon Phase View
    var moonPhase: some View {
        VStack {
            VForm {
                HStack(spacing: 5) {
                    Image(systemName: "moon.fill")
                        .foregroundColor(.secondary)

                    Text("MOON PHASE")
                        .font(.system(.footnote))
                        .foregroundColor(.secondary)
                }

                Text(weatherForecast.today.weatherDayDaily.moonPhase.rawValue)
                    .font(.system(.title2))

                if weatherForecast.today.weatherDayDaily.moonPhase == .new {
                    Image(systemName: "moonphase.new.moon")
                        .resizable()
                        .scaledToFit()
                        .imageScale(.small)
                        .frame(width: 50, height: 50, alignment: .center)
                } else if weatherForecast.today.weatherDayDaily.moonPhase == .waxingCrescent {
                    Image(systemName: "moonphase.waxing.crescent")
                        .resizable()
                        .scaledToFit()
                        .imageScale(.small)
                        .frame(width: 50, height: 50, alignment: .center)
                } else if weatherForecast.today.weatherDayDaily.moonPhase == .firstQuarter {
                    Image(systemName: "moonphase.first.quarter")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                } else if weatherForecast.today.weatherDayDaily.moonPhase == .waxingGibous {
                    Image(systemName: "moonphase.waxing.gibbous")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                } else if weatherForecast.today.weatherDayDaily.moonPhase == .full {
                    Image(systemName: "moonphase.full.moon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                } else if weatherForecast.today.weatherDayDaily.moonPhase == .waningGibous {
                    Image(systemName: "moonphase.waning.gibbous")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                } else if weatherForecast.today.weatherDayDaily.moonPhase == .lastQuarter {
                    Image(systemName: "moonphase.last.quarter")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                } else if weatherForecast.today.weatherDayDaily.moonPhase == .waningCrescent {
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
        }
    }

    // MARK: - Location Map
    @ViewBuilder
    var locationMap: some View {
        @State var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: coordLocation.lat,
                longitude: coordLocation.lon
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.3,
                longitudeDelta: 0.3
            )
        )

        ZStack {
            Map(coordinateRegion: $region)
                .disabled(true)
                .frame(minHeight: 500)
            ZStack {
                Circle()
                    .foregroundColor(.blue)
                Text(weatherForecast.current.temp.toInt().toString())
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .bold()
            }
            .frame(width: 30, height: 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(5)
    }

    // MARK: - The weather detail Views
    @ViewBuilder
    var weatherDetailViews: some View {
        VStack(spacing: 5) {
            WeatherDetailHStack {
                feelsLike
                    .help("Shows what the current temperature feels like.")
                Spacer()
                humidity
                    .help("Shows the current humidity.")
                Spacer()
                visibility
                    .help("Shows the current visibility (in km).")
                Spacer()
                uvi
                    .help("A gradient that shows the UV Index for this hour.")
                if weatherForecast.current.precipitation != 0 {
                    Spacer()
                    rainfall
                        .help("Shows the rainfall.")
                }
                Spacer()
                moonPhase
                    .help("Current moon phase")
            }

            Text("Weather for \(weatherForecast.address)")
                .font(.system(.footnote))
        }
    }
}

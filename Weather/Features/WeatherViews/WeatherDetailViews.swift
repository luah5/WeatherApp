//
//  WeatherDetailViews.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 12/05/23.
//

import SwiftUI
import MapKit

// swiftlint:disable file_length
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
        VForm {
            HStack(spacing: 5) {
                Image(systemName: "humidity")
                    .controlSize(.small)
                    .foregroundStyle(.secondary)
                Text("HUMIDITY")
                    .font(.system(.footnote))
                    .foregroundStyle(.secondary)
            }

            Text("\(weatherForecast.current.humidity)%")
                .font(.system(.title))

            Spacer()

            Text("The dew point is \(weatherForecast.current.dewPoint.toInt())º")
                .font(.system(.footnote))
        }
    }

    // MARK: - Feels Like View
    var feelsLike: some View {
        VForm {
            HStack(spacing: 5) {
                Image(systemName: "thermometer.medium")
                    .controlSize(.small)
                    .foregroundStyle(.secondary)
                Text("FEELS LIKE")
                    .font(.system(.footnote))
                    .foregroundStyle(.secondary)
            }
            Text("\(weatherForecast.current.feelsLike.toInt())º")
                .font(.system(.largeTitle))

            Spacer()

            let tempDiff: Float = weatherForecast.current.feelsLike - weatherForecast.current.temp
            let current: WeatherHour = weatherForecast.current
            if tempDiff >= -2 && tempDiff <= 2 {
                Text("Similar to the real temperature.")
                    .font(.system(.footnote))
            } else if current.humidity >= 70 {
                if tempDiff > 2 {
                    Text("Humidity is making it feel warmer.")
                        .font(.system(.footnote))
                } else if tempDiff < -2 {
                    Text("Humidity is making it feel cooler.")
                        .font(.system(.footnote))
                }
            } else if (current.windSpeed >= 5 || current.windGust >= 10) && tempDiff < -2 {
                Text("Wind is making it feel cooler.")
                    .font(.system(.footnote))
            } else if (current.windSpeed <= 2.5 || current.windGust <= 2.5) && tempDiff > 2 {
                Text("Wind is making it feel warmer.")
                    .font(.system(.footnote))
            }
        }
    }

    // MARK: - Visibility View
    var visibility: some View {
        VForm {
            HStack(spacing: 5) {
                Image(systemName: "eye")
                    .controlSize(.small)
                    .foregroundStyle(.secondary)
                Text("VISIBILITY")
                    .font(.system(.footnote))
                    .foregroundStyle(.secondary)
            }
            Text("\(weatherForecast.current.visibility) km")
                .font(.system(.largeTitle))

            Spacer()

            if weatherForecast.current.visibility >= 15 {
                Text("It's perfectly clear")
                    .font(.system(.footnote))
            } else if weatherForecast.current.visibility < 30 && weatherForecast.current.clouds > 25 {
                Text("Clouds are lowering visibility")
                    .font(.system(.footnote))
            } else {
                Text("Pollution is lowering visbility")
                    .font(.system(.footnote))
            }
        }
    }

    // MARK: - UV Index View
    var uvi: some View {
        VForm {
            HStack(spacing: 5) {
                Image(systemName: "sun.max.fill")
                    .controlSize(.small)
                    .foregroundStyle(.secondary)
                Text("UV INDEX")
                    .font(.system(.footnote))
                    .foregroundStyle(.secondary)
            }
            VStack(alignment: .leading) {
                Text("\(weatherForecast.current.uvi)")
                    .font(.system(.title))
                    .padding(.trailing)

                if weatherForecast.current.uvi < 2 {
                    Text("Low")
                        .font(.system(.title2))
                } else if weatherForecast.current.uvi <= 5 {
                    Text("Moderate")
                        .font(.system(.title2))
                } else if weatherForecast.current.uvi <= 8 {
                    Text("High")
                        .font(.system(.title2))
                } else if weatherForecast.current.uvi > 10 {
                    Text("Extreme")
                        .font(.system(.title2))
                }
            }

            Spacer()

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
    }

    // MARK: - Sun Position View
    var sunPosition: some View {
        VForm {
            VStack {
                ZStack {
                    SineLine()
                        .stroke(lineWidth: 2)
                        .foregroundStyle(.secondary)
                        .frame(width: 300, height: 200)

                    Image(systemName: "sun.max.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .offset(x: 20, y: -40)
                        .foregroundStyle(.yellow)
                }
            }
        }
    }

    // MARK: - Rainfall View
    var rainfall: some View {
        VForm {
            HStack(spacing: 5) {
                Image(systemName: "drop.fill")
                    .controlSize(.small)
                    .foregroundStyle(.secondary)
                Text("RAINFALL")
                    .font(.system(.footnote))
                    .foregroundStyle(.secondary)
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

    // MARK: - Moon Phase View
    var moonPhase: some View {
        VForm {
            HStack(spacing: 5) {
                Image(systemName: "moon.fill")
                    .foregroundStyle(.secondary)

                Text("MOON PHASE")
                    .font(.system(.footnote))
                    .foregroundStyle(.secondary)
            }

            Text(weatherForecast.today.weatherDayDaily.moonPhase.rawValue)
                .font(.system(.title2))

            if weatherForecast.today.weatherDayDaily.moonPhase == .new {
                Image(systemName: "moonphase.new.moon")
                    .resizable()
                    .scaledToFit()
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

            Spacer()

            if weatherForecast.current.clouds >= 75 {
                Text("The moon is currently obscured due to high cloud coverage.")
                    .font(.system(.footnote))
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
                    .foregroundStyle(.blue)
                Text(weatherForecast.current.temp.toInt().toString())
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                    .bold()
            }
            .frame(width: 30, height: 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(5)
    }

    var moonForecast: some View {
        VForm {
            HStack(spacing: 5) {
                Image(systemName: "moon.haze.fill")
                    .foregroundStyle(.secondary)
                Text("MOON")
                    .font(.system(.footnote))
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: -40) {
                VStack(spacing: -100) {
                    Circle()
                        .trim(from: 0.5, to: 0.75)
                        .stroke(.black, lineWidth: 2)
                        .frame(width: 100, height: 100)
                    Circle()
                        .fill(.blue)
                        .frame(width: 10, height: 10)
                        .offset(x: -50, y: 50)
                    Text(weatherForecast.today.weatherDayDaily.moonrise.toTimestamp3())
                        .offset(x: -50, y: 150)
                        .bold()
                }

                Image(systemName: "moon.fill")
                    .offset(y: -40)

                VStack(spacing: -100) {
                    Circle()
                        .trim(from: 0.75, to: 1.0)
                        .stroke(.black, lineWidth: 2)
                        .frame(width: 100, height: 100)
                    Circle()
                        .fill(.black)
                        .frame(width: 10, height: 10)
                        .offset(x: 50, y: 50)
                    Text(weatherForecast.today.weatherDayDaily.moonset.toTimestamp3())
                        .offset(x: 50, y: 150)
                        .bold()
                }
            }
            .offset(x: 20)
        }
    }

    var sunForecast: some View {
        VStack {
            VForm {
                HStack(spacing: 5) {
                    Image(systemName: "sun.max.fill")
                        .foregroundStyle(.secondary)
                    Text("SUN")
                        .font(.system(.footnote))
                        .foregroundStyle(.secondary)
                }

                HStack(spacing: -40) {
                    VStack(spacing: -100) {
                        Circle()
                            .trim(from: 0.5, to: 0.75)
                            .stroke(.black, lineWidth: 2)
                            .frame(width: 100, height: 100)
                        Circle()
                            .fill(.blue)
                            .frame(width: 10, height: 10)
                            .offset(x: -50, y: 50)
                        Text(weatherForecast.today.weatherDayDaily.sunrise.toTimestamp3())
                            .offset(x: -50, y: 150)
                            .bold()
                    }

                    Image(systemName: "sun.max.fill")
                        .offset(y: -40)

                    VStack(spacing: -100) {
                        Circle()
                            .trim(from: 0.75, to: 1.0)
                            .stroke(.black, lineWidth: 2)
                            .frame(width: 100, height: 100)
                        Circle()
                            .fill(.black)
                            .frame(width: 10, height: 10)
                            .offset(x: 50, y: 50)
                        Text(weatherForecast.today.weatherDayDaily.sunset.toTimestamp3())
                            .offset(x: 50, y: 150)
                            .bold()
                    }
                }
                .offset(x: 20)
            }
        }
    }

    var wind: some View {
        VStack {
            VForm {
                HStack(spacing: 5) {
                    Image(systemName: "wind")
                        .foregroundStyle(.secondary)

                    Text("WIND")
                        .font(.system(.footnote))
                        .foregroundStyle(.secondary)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text("\(weatherForecast.current.windSpeed.toInt())km/h")
                        .font(.system(.largeTitle))

                    Text(degreesToCompassName(weatherForecast.current.windDegInt))
                        .font(.system(.title2))
                }

                Spacer()

                Text("Gust \(weatherForecast.today.weatherHours.first!.windGust.toInt()) km/h")
                    .font(.system(.footnote))
                    .foregroundStyle(.secondary)
            }
        }
    }

    // MARK: - The weather detail Views
    @ViewBuilder
    var weatherDetailViews: some View {
        VStack(spacing: 5) {
            WeatherDetailHStack {
                feelsLike
                    .help("Shows what the current temperature feels like.")
                    .frame(minWidth: 275, minHeight: 200)
                Spacer()
                humidity
                    .help("Shows the current humidity.")
                    .frame(minWidth: 275, minHeight: 200)
                Spacer()
                visibility
                    .help("Shows the current visibility (in km).")
                    .frame(minWidth: 275, minHeight: 200)
                Spacer()
                uvi
                    .help("A gradient that shows the UV Index for this hour.")
                    .frame(minWidth: 275, minHeight: 200)
            }

            WeatherDetailHStack {
                if weatherForecast.current.precipitation != 0 {
                    Spacer()
                    rainfall
                        .help("Shows the rainfall.")
                        .frame(minWidth: 275, minHeight: 200)
                }
                Spacer()
                moonPhase
                    .help("Current moon phase.")
                    .frame(minWidth: 275, minHeight: 200)
                Spacer()
                wind
                    .help("Current wind information.")
                    .frame(minWidth: 275, minHeight: 200)
                Spacer()
                moonForecast
                    .help("Moonrise and moonset.")
                    .frame(minWidth: 275, minHeight: 200)
                Spacer()
                sunForecast
                    .help("Sunrise and sunset.")
                    .frame(minWidth: 275, minHeight: 200)
            }

            Text("Weather for \(weatherForecast.address)")
                .font(.system(.footnote))
                .bold()
        }
    }
}
// swiftlint:enable file_length

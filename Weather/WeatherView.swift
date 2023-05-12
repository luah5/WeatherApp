//
//  ContentView.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 17/04/23.
//

import SwiftUI
import CoreLocation
import MapKit

/// The main view for looking at all the weather
struct WeatherView: View {
    let weatherForecast: WeatherForecast = .init()
    let timer = Timer.publish(
        every: 1,
        on: .main,
        in: .common
    ).autoconnect()
    @State private var reload: Bool = false
    @State var sheetIsPresented: Bool = false
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 37.789467,
            longitude: -122.416772
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.5,
            longitudeDelta: 0.5
        )
    )

    var body: some View {
        NavigationSplitView {
            Text("Location")
        } detail: {
            Spacer()
            topView

            Form {
                if weatherForecast.weatherData.precipitationInNextHour {
                    minutelyPrecipitation
                }

                Section {
                    hourlyForecast
                }
                Section {
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.secondary)
                        Text("4 DAY WEATHER")
                            .foregroundColor(.secondary)
                    }

                    days
                }
            }
            .formStyle(.grouped)

            weatherDetailViews
        }
        .toolbar {
            Button {
                sheetIsPresented.toggle()
            } label: {
                Image(systemName: "plus.app")
                    .foregroundColor(.secondary)
            }
            .sheet(isPresented: $sheetIsPresented) {
                ZStack {
                    Map(coordinateRegion: $region)

                    Button {
                        print(region.center)
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "mappin")
                            .scaledToFill()
                            .foregroundColor(.red)
                    }
                    .buttonStyle(.plain)
                    .frame(width: 50, height: 50)
                }
                .frame(
                    minWidth: 100,
                    idealWidth: 750,
                    maxWidth: .greatestFiniteMagnitude,
                    minHeight: 100,
                    idealHeight: 750,
                    maxHeight: .greatestFiniteMagnitude
                )
            }
            .help("Add city, town or village.")
            .buttonStyle(.bordered)
        }
    }
}

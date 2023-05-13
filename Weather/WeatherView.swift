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
    @State private var locations: [WeatherMainView] = [
        WeatherMainView(
            location: Location(
                lat: 51.49883962676684,
                lon: -0.25169226373882936
            )
        )
    ]
    @State private var selection: Int = 0

    var body: some View {
        NavigationSplitView {
            VStack {
                ForEach(locations, id: \.weatherForecast.current.time) { location in
                    Button {
                        var index: Int = 0

                        for loc in locations {
                            if loc.weatherForecast.current.time == location.weatherForecast.current.time {
                                selection = index
                            }

                            index += 1
                        }
                    } label: {
                        HStack(spacing: 25) {
                            Text(location.weatherForecast.weatherData.location)
                                .help(location.weatherForecast.weatherData.location)
                            Text("\(String(location.weatherForecast.current.temp))º")
                        }
                        .frame(width: 125, height: 25)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 5
                            ).foregroundColor(Color.white)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.top)
        } detail: {
            locations[selection]
        }
        .toolbar {
            Button {
                sheetIsPresented.toggle()
            } label: {
                HStack {
                    Image(systemName: "plus.app")
                        .foregroundColor(.secondary)
                    Text("Add Location")
                }
            }
            .sheet(isPresented: $sheetIsPresented) {
                ZStack {
                    Map(coordinateRegion: $region)

                    Button {
                        sheetIsPresented.toggle()

                        locations.append(
                            WeatherMainView(
                                location: Location(
                                    location: region.center
                                )
                            )
                        )
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
        .navigationSplitViewColumnWidth(min: 125, ideal: 125, max: 125)
    }
}

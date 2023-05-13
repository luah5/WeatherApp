//
//  ContentView.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 17/04/23.
//

import SwiftUI
import Foundation
import CoreLocation
import MapKit

/// The main view for viewing the weather
struct WeatherView: View {
    @State var sheetIsPresented: Bool = false
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 51.49883962676684,
            longitude: -0.25169226373882936
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.005,
            longitudeDelta: 0.005
        )
    )
    @State private var coordinateLocations: [Location] = [
        Location(
            lat: 51.49883962676684,
            lon: -0.25169226373882936
        )
    ]
    @State private var locations: [WeatherMainView] = []
    @State private var selection: Int = 0

    init() {
        locations = []

        for coordinate in coordinateLocations {
            locations.append(
                WeatherMainView(
                    location: coordinate
                )
            )
        }
    }

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
                            Text(location.weatherForecast.address)
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
            Button("Set User default") {
                UserDefaults.standard.set(locations, forKey: "Units")
            }

            if locations.isEmpty {
                Text("Loading...")
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                ProgressView()
            } else {
                locations[selection]
            }
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
            .disabled(locations.count >= 10)
            .keyboardShortcut("n", modifiers: [.command, .option])
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

                        selection += 1
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

            Button {
                locations.remove(at: selection)

                selection = locations.count - 1
            } label: {
                HStack {
                    Image(systemName: "trash")
                    Text("Remove Location")
                }
            }
            .help("Remove selected location")
            .buttonStyle(.bordered)
            .disabled(locations.count == 1)
        }
        .navigationSplitViewColumnWidth(min: 125, ideal: 125, max: 125)
    }
}

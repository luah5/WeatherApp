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
    @State private var coordinateLocation: Locations = DataSave().coordinateLocations
    @State private var coordinateLocations: [Location] = DataSave().coordinateLocations.coordinates
    @State private var locations: [WeatherMainView] = DataSave().weatherMainViews
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
                        VStack(spacing: 25) {
                            HStack {
                                VStack {
                                    Text(location.weatherForecast.address)
                                        .fontWeight(.medium)
                                        .font(.system(.title))
                                    Text(
                                        String(
                                            location.weatherForecast.current.time.toTimestamp3()
                                        )
                                    )
                                }
                                Spacer()
                                VStack {
                                    Text("\(String(location.weatherForecast.current.temp))º")
                                        .font(.system(.title))
                                    Text("""
H: \(String(location.weatherForecast.today.maxTemp))º L: \(String(location.weatherForecast.today.maxTemp))º
""")
                                }
                            }
                        }
                        .frame(width: 250, height: 50)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 5
                            ).foregroundColor(Color.secondary)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.top)
        } detail: {
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

                        coordinateLocations.append(
                            Location(
                                location: region.center
                            )
                        )
                        coordinateLocation.coordinates = coordinateLocations

                        UserDefaults.standard.setValue(coordinateLocation.encode(), forKey: "locations")

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
                coordinateLocations.remove(at: selection)
                coordinateLocation.coordinates = coordinateLocations

                UserDefaults.standard.setValue(coordinateLocation.encode(), forKey: "locations")

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

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
    @State private var sheetIsPresented: Bool = false
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 51.5,
            longitude: -0.2
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.05,
            longitudeDelta: 0.05
        )
    )
    @State private var dataSave: DataSave = DataSave()

    var body: some View {
        NavigationSplitView {
            ScrollView(.vertical) {
                ForEach(dataSave.weatherMainViews, id: \.weatherForecast.current.time) { location in
                    Button {
                        var index: Int = 0

                        for loc in dataSave.weatherMainViews {
                            if loc.weatherForecast.current.time == location.weatherForecast.current.time {
                                dataSave.selection = index
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
                        .frame(
                            minWidth: 215,
                            maxWidth: .infinity,
                            minHeight: 50,
                            maxHeight: 50
                        )
                        .background(
                            RoundedRectangle(
                                cornerRadius: 5
                            )
                            .foregroundColor(
                                Color(
                                    nsColor: NSColor.textColor
                                )
                            )
                            .colorInvert()
                        )
                    }
                    .buttonStyle(.plain)

                    Divider()
                }
            }
            .padding(.top)
        } detail: {
            if dataSave.weatherMainViews.isEmpty {
                Text("dataSave.weatherMainViews.empty = TRUE")
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            } else {
                dataSave.weatherMainViews[safe: dataSave.selection]
                    .background(
                        dataSave.weatherMainViews[
                            safe: dataSave.selection]!.weatherForecast.current.weather.background.image
                            .scaledToFill()
                    )
            }
        }
        .toolbar {
            Button {
                sheetIsPresented.toggle()
            } label: {
                HStack(spacing: 5) {
                    Image(systemName: "plus.app")
                        .foregroundColor(.secondary)
                    Text("Add Location")
                }
            }
            .disabled(dataSave.weatherMainViews.count >= 10)
            .keyboardShortcut("n")
            .sheet(isPresented: $sheetIsPresented) {
                ZStack {
                    Map(coordinateRegion: $region)

                    Button {
                        sheetIsPresented = false

                        dataSave.coordinateLocations.coordinates.append(
                            Location(
                                location: region.center,
                                location2: getAddressFromCoordinates(
                                    location: Location(
                                        location: region.center,
                                        location2: "nil"
                                    )
                                )
                            )
                        )

                        UserDefaults.standard.setValue(
                            dataSave.coordinateLocations.encode(),
                            forKey: "locations"
                        )

                        DispatchQueue.global(qos: .userInitiated).async {
                            dataSave.weatherMainViews.append(
                                WeatherMainView(
                                    location: dataSave.coordinateLocations.coordinates.last!
                                )
                            )

                            dataSave.selection += 1
                        }
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
                dataSave.weatherMainViews.remove(at: dataSave.selection)
                dataSave.coordinateLocations.coordinates.remove(at: dataSave.selection)

                UserDefaults.standard.setValue(dataSave.coordinateLocations.encode(), forKey: "locations")

                dataSave.selection = dataSave.weatherMainViews.count - 1
            } label: {
                HStack(spacing: 5) {
                    Image(systemName: "trash")
                    Text("Remove Location")
                }
            }
            .help("Remove selected location")
            .buttonStyle(.bordered)
            .disabled(dataSave.weatherMainViews.count == 1)
        }
        .navigationSplitViewColumnWidth(215)
        .navigationTitle("")
        .toolbarBackground(.white.opacity(0), for: .automatic)
    }
}

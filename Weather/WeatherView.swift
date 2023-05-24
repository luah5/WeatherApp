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
    @State private var dataSave: DataSave = .init()

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
                        .frame(width: 250, height: 50)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 5
                            ).foregroundColor(Color.secondary)
                        )
                    }
                    .buttonStyle(.plain)

                    Divider()
                }
            }
            .padding(.top)
        } detail: {
            if dataSave.weatherMainViews.isEmpty {
                Text("No dataSave.weatherMainViews")
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            } else {
                dataSave.weatherMainViews[dataSave.selection]
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
            .disabled(dataSave.weatherMainViews.count >= 10)
            .keyboardShortcut("n")
            .sheet(isPresented: $sheetIsPresented) {
                ZStack {
                    Map(coordinateRegion: $region)

                    Button {
                        sheetIsPresented.toggle()

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

                        dataSave.weatherMainViews.append(
                            WeatherMainView(
                                location: dataSave.coordinateLocations.coordinates.last!
                            )
                        )

                        UserDefaults.standard.setValue(
                            dataSave.coordinateLocations.encode(),
                            forKey: "locations"
                        )

                        dataSave.selection += 1
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
                HStack {
                    Image(systemName: "trash")
                    Text("Remove Location")
                }
            }
            .help("Remove selected location")
            .buttonStyle(.bordered)
            .disabled(dataSave.weatherMainViews.count == 1)
        }
        .navigationSplitViewColumnWidth(215)
    }
}

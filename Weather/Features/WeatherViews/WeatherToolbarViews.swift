//
//  WeatherToolbarViews.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 02/06/23.
//

import SwiftUI
import MapKit

extension WeatherView {
    @ViewBuilder
    var toolbarViews: some View {
        Button {
            sheetIsPresented.toggle()
        } label: {
            HStack(spacing: 5) {
                Image(systemName: "plus.app")
                    .foregroundStyle(.secondary)
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

                    DispatchQueue.global(qos: .userInteractive).async {
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

                        DispatchQueue.global(qos: .utility).async {
                            UserDefaults.standard.setValue(
                                dataSave.coordinateLocations.encode(),
                                forKey: "locations"
                            )
                        }

                        dataSave.weatherMainViews.append(
                            WeatherMainView(
                                location: dataSave.coordinateLocations.coordinates.last!,
                                id: dataSave.weatherMainViews.count,
                                save: dataSave
                            )
                        )

                        dataSave.selection += 1
                    }
                } label: {
                    Image(systemName: "mappin")
                        .scaledToFill()
                        .foregroundStyle(.red)
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

            DispatchQueue.global(qos: .background).async {
                UserDefaults.standard.setValue(dataSave.coordinateLocations.encode(), forKey: "locations")
            }

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
        .animation(.easeOut(duration: 1), value: 12)

        Button {
            splits += 1
        } label: {
            Image(systemName: "square.split.2x1")
        }
    }
}

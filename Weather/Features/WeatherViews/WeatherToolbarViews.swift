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
        @State var isLoading: Bool = false

        Button {
            mapShown.toggle()
        } label: {
            if isLoading {
                ProgressView()
            } else {
                HStack(spacing: 5) {
                    Image(systemName: "plus.app")
                        .foregroundStyle(.secondary)
                    Text("Add Location")
                }
            }
        }
        .disabled(dataSave.weatherMainViews.count >= 10)
        .keyboardShortcut("n")
        .sheet(isPresented: $mapShown) {
            ZStack {
                Map(coordinateRegion: $region)

                Button {
                    isLoading = true
                    mapShown = false

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

                        isLoading = false
                        dataSave.intSelection += 1
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
            dataSave.weatherMainViews.remove(at: dataSave.intSelection)
            dataSave.coordinateLocations.coordinates.remove(at: dataSave.intSelection)

            DispatchQueue.global(qos: .background).async {
                UserDefaults.standard.setValue(dataSave.coordinateLocations.encode(), forKey: "locations")
            }

            dataSave.intSelection = dataSave.weatherMainViews.count - 1
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

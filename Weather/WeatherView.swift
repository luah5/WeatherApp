//
//  ContentView.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 17/04/23.
//

import SwiftUI
import MapKit

/// The main view for viewing the weather
struct WeatherView: View {
    @State var splits: Int = 1
    @State var mapShown: Bool = false
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 51.5,
            longitude: -0.2
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.05,
            longitudeDelta: 0.05
        )
    )
    @State var dataSave: DataSave = DataSave()

    var body: some View {
        NavigationSplitView {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 25)
                List(selection: $dataSave.intSelection) {
                    Section {
                        ForEach(dataSave.weatherMainViews) { item in
                            SidebarItemView(
                                forecast: item.weatherForecast,
                                selection: item.index,
                                dataSave: dataSave
                            )
                        }
                    }
                }
            }
            .background(
                dataSave.selectedWeatherMainView?.weatherForecast.current.weather.background.color
                    .opacity(0.7)
            )
        } detail: {
            if let selection = dataSave.selectedWeatherMainView {
                selection
                    .background(
                        selection.weatherForecast.current.weather.background.image
                            .scaledToFill()
                    )
            } else {
                Text("Loading, waiting for DataSave to complete initializing")
            }
        }
        .toolbar {
            toolbarViews
                .background(.opacity(0))
        }
        .navigationSplitViewColumnWidth(300)
        .navigationTitle("")
        .toolbarBackground(Color.accentColor.opacity(0), for: .windowToolbar)
        //.toolbar(.hidden, for: .)
    }
}

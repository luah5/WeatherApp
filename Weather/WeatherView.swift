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
    @State var sheetIsPresented: Bool = false
    @State var splits: Int = 1
    @State var index: Int = -1
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
            List(selection: $dataSave.selection) {
                Section {
                    ForEach(dataSave.weatherMainViews) { item in
                        SidebarItemView(weatherItem: item, save: dataSave)
                    }
                }
            }
            .background(
                dataSave.weatherMainViews[safe: dataSave.selection]?
                    .weatherForecast.current.weather.background.image
                    .scaledToFill()
                    .opacity(0)
            )
            .scrollDisabled(true)
        } detail: {
            dataSave.weatherMainViews[safe: dataSave.selection]
                .background(
                    dataSave.weatherMainViews[safe: dataSave.selection]?
                        .weatherForecast.current.weather.background.image
                        .scaledToFill()
                )
        }
        .toolbar {
            toolbarViews
                .background(.opacity(0))
        }
        .navigationSplitViewColumnWidth(300)
        .navigationTitle("")
        .toolbarBackground(Color.accentColor.opacity(0), for: .automatic)
    }
}

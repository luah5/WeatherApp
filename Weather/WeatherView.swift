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
                    ForEach(dataSave.weatherMainViews, id: \.index) { item in
                        SidebarItemView(weatherItem: item)
                    }
                }
            }
            .background(
                dataSave.weatherMainViews[dataSave.selection]
                    .weatherForecast.current.weather.background.image
                    .scaledToFill()
                    .opacity(0.3)
            )
            .scrollDisabled(true)
            .scrollDismissesKeyboard(.never)
        } detail: {
            dataSave.weatherMainViews[dataSave.selection]
                .background(
                    dataSave.weatherMainViews[dataSave.selection]
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

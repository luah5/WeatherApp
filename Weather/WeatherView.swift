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
                    ForEach(dataSave.weatherMainViews, id: \.id) { item in
                        NavigationLink {
                            item
                                .background(
                                    item.weatherForecast.current.weather.background.image
                                        .scaledToFill()
                                )
                        } label: {
                            VStack(spacing: 25) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(item.weatherForecast.address)
                                            .fontWeight(.medium)
                                            .font(.system(.title))
                                            .help(item.weatherForecast.address)
                                        Text(item.weatherForecast.current.time.toTimestamp3())
                                    }

                                    Spacer()

                                    VStack {
                                        Text(String(item.weatherForecast.current.temp))
                                            .font(.system(.title))
                                        Text("""
H: \(String(item.weatherForecast.today.maxTemp))º L: \(String(item.weatherForecast.today.maxTemp))º
""")
                                    }
                                }
                            }
                        }
                        Divider()
                    }
                }
            }
        } detail: {
            dataSave.weatherMainViews[dataSave.selection]
                .background(
                    dataSave.weatherMainViews[dataSave.selection].weatherForecast.current.weather.background.image
                    .scaledToFill()
                )
        }
        .toolbar {
            toolbarViews
        }
        .navigationSplitViewColumnWidth(300)
        .navigationTitle("")
        .toolbarBackground(Color.accentColor.opacity(0), for: .windowToolbar)
    }
}

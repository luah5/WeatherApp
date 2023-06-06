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
import UserNotifications

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
            VStack {
                Button("Request Permission") {
                    UNUserNotificationCenter.current().requestAuthorization(
                        options: [.alert, .badge, .sound]
                    ) { success, error in
                        if success {
                            print("All set!")
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                }

                Button("Schedule Notification") {
                    let content = UNMutableNotificationContent()
                    content.title = "Precipitation Warning"
                    content.subtitle = "98% chance of precipitation in the next hour."
                    content.sound = UNNotificationSound.default

                    // show this notification five seconds from now
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

                    // choose a random identifier
                    let request = UNNotificationRequest(
                        identifier: UUID().uuidString,
                        content: content,
                        trigger: trigger
                    )

                    // add our notification request
                    UNUserNotificationCenter.current().add(request)
                }
            }
            List(selection: $dataSave.selection) {
                Section {
                    ForEach(dataSave.weatherMainViews, id: \.index) { item in
                        SidebarItemView(weatherItem: item, save: dataSave)
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

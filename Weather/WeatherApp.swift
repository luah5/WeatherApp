//
//  WeatherApp.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 17/04/23.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView.init()
                .presentedWindowToolbarStyle(
                    .unifiedCompact(
                        showsTitle: false
                    )
                )
            /*
                .background(
                    Image("Clouds")
                        .scaledToFit()
                )
            */
        }

        Settings {
            SettingsView()
                .frame(width: 600, height: 600)
                .presentedWindowToolbarStyle(.unifiedCompact(
                        showsTitle: false
                    )
                )
        }
    }
}

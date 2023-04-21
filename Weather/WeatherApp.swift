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
            WeatherView()
                .presentedWindowToolbarStyle(.unifiedCompact(showsTitle: false))
        }

        Settings {
            SettingsView()
                .frame(width: 600, height: 600)
        }
    }
}

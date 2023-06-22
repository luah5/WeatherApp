//
//  WeatherApp.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 17/04/23.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView()
                .presentedWindowToolbarStyle(.expanded)
                .onAppear {
                    WeatherSave()
                }
                .onDisappear {
                    WeatherSave()
                }
        }
        .commands {
            WACommands()
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

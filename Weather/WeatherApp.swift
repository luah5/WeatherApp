//
//  WeatherApp.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 17/04/23.
//

import SwiftUI
import BackgroundTasks

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView()
                .presentedWindowToolbarStyle(
                    .unifiedCompact(
                        showsTitle: false
                    )
                )
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

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
                .toolbar(.hidden, for: .windowToolbar)
                .onAppear {
                    print("Appeared!")
                    DispatchQueue.global(qos: .userInitiated).async { _ = WeatherSave(.positive) }
                }
                .onDisappear {
                    DispatchQueue.global(qos: .userInitiated).async { _ = WeatherSave(.positive) }
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

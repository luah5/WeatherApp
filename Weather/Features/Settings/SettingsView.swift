//
//  SettingsView.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 20/04/23.
//

import SwiftUI

enum Units: String {
    case metric = "Metric"
    case imperial = "Imperial"
}

/// The struct for viewing settings.
struct SettingsView: View {
    @State private var units: Units = .metric
    var body: some View {
        Form {
            Section {
                Picker("Units", selection: $units) {
                    Text("Metric")
                        .tag(Units.metric)
                    Text("Imperial")
                        .tag(Units.imperial)
                }
            }
        }
        .formStyle(.grouped)
    }
}

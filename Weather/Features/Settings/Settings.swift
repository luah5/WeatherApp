//
//  Settings.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 21/06/23.
//

import Foundation
import SwiftUI

class SettingsData: ObservableObject {
    enum Units: String, CaseIterable {
        case metric = "Metric"
        case imperial = "Imperial"
    }

    @Published var units: Units = .metric
}

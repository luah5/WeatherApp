//
//  WeatherMainView.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 13/05/23.
//

import SwiftUI
import MapKit

/// The weather view that is shown in the main view
struct WeatherMainView: View, Identifiable, Hashable {
    static func == (lhs: WeatherMainView, rhs: WeatherMainView) -> Bool {
        lhs.id == rhs.id
    }

    let id: UUID = UUID()
    let coordLocation: Location, index: Int, weatherForecast: WeatherForecast

    init(location: Location, id: Int, save: DataSave) {
        self.coordLocation = location

        self.weatherForecast = WeatherForecast(
            coordinateLocation: location,
            save
        )

        self.index = id
        DispatchQueue.global(qos: .background).async {
            while true {
                _ = WeatherSave(.positive)
                sleep(600)
            }
        }
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Spacer()

            HStack {
                Spacer()
                topView
                Spacer()
            }
            .frame(maxWidth: .infinity)

            if !weatherForecast.weatherData.alerts.isEmpty {
                weatherAlerts
            }

            if weatherForecast.weatherData.precipitationInNextHour {
                VForm {
                    minutelyPrecipitation
                }
            }

            VForm {
                hourlyForecast
            }

            VForm {
                days
            }

            MapForm {
                locationMap
            }

            weatherDetailViews
        }
        .frame(maxWidth: .infinity)
    }
}

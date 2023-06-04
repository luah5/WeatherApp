//
//  WeatherMainView.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 13/05/23.
//

import SwiftUI
import CoreLocation
import MapKit

/// The weather view that is shown in the main view
struct WeatherMainView: View {
    var coordLocation: Location, index: Int, weatherForecast: WeatherForecast
    var height: CGFloat = 150

    init(location: Location, id: Int, save: DataSave) {
        coordLocation = location
        var weatherSave = WeatherSave(dataSave: save)

        weatherForecast = WeatherForecast(
            coordinateLocation: location,
            save
        )

        index = id
        DispatchQueue.global(qos: .background).async {
            sleep(600)
            weatherSave.reloadData(save: save)
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

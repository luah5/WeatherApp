//
//  Save.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 13/05/23.
//

import Foundation

struct DataSave {
    var coordinateLocations: [Location] = []
    var weatherMainViews: [WeatherMainView] = []

    init() {
        coordinateLocations = [
            Location(
                lat: 51.49883962676684,
                lon: -0.25169226373882936
            ),
            Location(
                lat: 51.49883962676684,
                lon: -0.25169226373882936
            )
        ]

        for location in coordinateLocations {
            weatherMainViews.append(
                WeatherMainView(
                    location: location
                )
            )
        }
    }
}

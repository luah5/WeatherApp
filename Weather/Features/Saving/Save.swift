//
//  Save.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 13/05/23.
//

import Foundation

struct DataSave {
    var coordinateLocations: Locations
    var weatherMainViews: [WeatherMainView]

    init() {
        weatherMainViews = []
        coordinateLocations = .init(fromString: "")

        if UserDefaults.standard.string(forKey: "locations") == nil {
            coordinateLocations.coordinates = [
                Location(
                    lat: 51.511533,
                    lon: -0.125112,
                    location: "Covent Garden"
                )
            ]
            UserDefaults.standard.set(coordinateLocations.encode(), forKey: "locations")
        }

        coordinateLocations = .init(fromString: UserDefaults.standard.string(forKey: "locations")!)

        for location in coordinateLocations.coordinates {
            weatherMainViews.append(
                WeatherMainView(
                    location: location
                )
            )
        }
    }
}

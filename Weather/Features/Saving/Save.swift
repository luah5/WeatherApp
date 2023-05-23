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
        print(UserDefaults.standard.string(forKey: "locations"))
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

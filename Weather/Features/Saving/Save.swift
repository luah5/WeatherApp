//
//  Save.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 13/05/23.
//

import Foundation

/// A structure to save data between sessions
struct DataSave {
    var coordinateLocations: Locations, weatherMainViews: [WeatherMainView], selection: Int

    init() {
        weatherMainViews = []
        coordinateLocations = Locations(fromString: "")

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

        selection = 0
        if UserDefaults.standard.string(forKey: "location_selection") == nil {
            UserDefaults.standard.set(0, forKey: "location_selection")
        } else {
            selection = Int(UserDefaults.standard.string(forKey: "location_selection")!) ?? 0
        }

        coordinateLocations = Locations(
            fromString: UserDefaults.standard.string(forKey: "locations") ?? "50,50,error"
        )

        var index: Int = 0
        for location in coordinateLocations.coordinates {
            weatherMainViews.append(
                WeatherMainView(
                    location: location,
                    id: index,
                    save: self
                )
            )
            index += 1
        }
    }
}

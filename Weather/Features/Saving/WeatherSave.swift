//
//  WeatherSave.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 03/06/23.
//

import Foundation
import SwiftyJSON
import SwiftUI

struct WeatherSave {
    var lastSave: Int, lastSaveJSON: JSONDecoder

    init(dataSave: DataSave) {
        let data: String = UserDefaults.standard.string(forKey: "weatherSave") ?? "Error"

        UserDefaults.standard.set(NSDate().timeIntervalSince1970, forKey: "lastSave")

        if data == "Error" {
            for location in dataSave.coordinateLocations.coordinates {
                let url: String = "https://api.openweathermap.org/data/2.5/forecast?"

                guard let URL = URL(
                    string: constructURL(
                        url,
                        location.locationString
                    )
                ) else {
                    throwNSAlert(messageText: "URL: \(constructURL(url, location.locationString)) does not exist.", severity: .critical)
                    fatalError()
                }

                do {
                    UserDefaults.standard.set(
                        try String(contentsOf: URL, encoding: .ascii),
                        forKey: "weatherSave"
                    )
                } catch {
                    throwNSAlert(messageText: "Failed to gather weather data", severity: .critical)
                    fatalError("Failed to gather weather data")
                }
            }
        }
    }

    func reloadData(save: DataSave) {
        for location in save.coordinateLocations.coordinates {
            let url: String = "https://api.openweathermap.org/data/2.5/forecast?"

            guard let URL = URL(
                string: constructURL(
                    url,
                    location.locationString
                )
            ) else {
                throwNSAlert(messageText: "There was an error gathering weather data in the background", severity: .warning)
                
                return
            }

            do {
                UserDefaults.standard.set(
                    try String(contentsOf: URL, encoding: .ascii),
                    forKey: "weatherSave"
                )
            } catch {
                throwNSAlert(messageText: "There was an error gathering weather data in the background.", severity: .warning)
            }
        }
    }
}

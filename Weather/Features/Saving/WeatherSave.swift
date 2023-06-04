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
    var lastSave: Int, lastSaveJSON: String

    init(dataSave: DataSave) {
        lastSaveJSON = UserDefaults.standard.string(
            forKey: "weatherSave"
        ) ?? "Error"
        let currentTime: Int = Int(NSDate().timeIntervalSince1970)

        if let date = UserDefaults.standard.value(forKey: "lastSave") {
            lastSave = Int(String(describing: date)) ?? 743
            if currentTime - lastSave >= 3600 || lastSaveJSON == "Error" {
                reloadData(save: dataSave)
            }
        } else {
            lastSave = Int(NSDate().timeIntervalSince1970)
            reloadData(save: dataSave)
        }

        UserDefaults.standard.set(currentTime, forKey: "lastSave")
    }

    mutating func reloadData(save: DataSave) {
        for location in save.coordinateLocations.coordinates {
            let url: String = "https://api.openweathermap.org/data/2.5/forecast?"

            guard let URL = URL(
                string: constructURL(
                    url,
                    location.urlVersion
                )
            ) else {
                throwNSAlert(
                    messageText: "There was an error gathering weather data in the background.",
                    severity: .warning
                )

                return
            }

            do {
                let contents: String = try String(contentsOf: URL, encoding: .ascii)

                lastSaveJSON = contents
                UserDefaults.standard.set(
                    contents,
                    forKey: "weatherSave"
                )

                let unixEpoch: Int = Int(NSDate().timeIntervalSince1970)
                UserDefaults.standard.set(
                    unixEpoch,
                    forKey: "lastSave"
                )

                lastSave = unixEpoch
            } catch {
                throwNSAlert(
                    messageText: "There was an error gathering weather data in the background.",
                    severity: .warning
                )
            }
        }
    }
}

//
//  WeatherSave.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 03/06/23.
//

import Foundation

struct WeatherSave {
    var lastSaveJSON2Day: String, lastSaveJSON5Day: String

    init(dataSave: DataSave) {
        var lastSave: Int = 743
        lastSaveJSON5Day = UserDefaults.standard.string(
            forKey: "weatherSave5Day"
        ) ?? "Error"

        lastSaveJSON2Day = UserDefaults.standard.string(
            forKey: "weatherSave2Day"
        ) ?? "Error"

        let currentTime: Int = Int(NSDate().timeIntervalSince1970)

        if let twoDayDate = UserDefaults.standard.value(forKey: "lastSave2Day") {
            lastSave = Int(String(describing: twoDayDate)) ?? 743
            if currentTime - lastSave >= 300 || lastSaveJSON5Day == "Error" {
                reloadDataTwoDay(locations: dataSave.coordinateLocations.coordinates)
            }
        } else {
            lastSave = Int(NSDate().timeIntervalSince1970)
            reloadDataTwoDay(locations: dataSave.coordinateLocations.coordinates)
        }

        if let fiveDayDate = UserDefaults.standard.value(forKey: "lastSave5Day") {
            lastSave = Int(String(describing: fiveDayDate)) ?? 743
            if currentTime - lastSave >= 3600 || lastSaveJSON5Day == "Error" {
                reloadDataFiveDay(locations: dataSave.coordinateLocations.coordinates)
            }
        } else {
            lastSave = Int(NSDate().timeIntervalSince1970)
            reloadDataFiveDay(locations: dataSave.coordinateLocations.coordinates)
        }
    }

    init() {
        var lastSave: Int = 743
        lastSaveJSON5Day = UserDefaults.standard.string(
            forKey: "weatherSave5Day"
        ) ?? "Error"

        lastSaveJSON2Day = UserDefaults.standard.string(
            forKey: "weatherSave2Day"
        ) ?? "Error"

        let locations: [Location] = Locations(
            fromString: UserDefaults.standard.string(
                forKey: "locations"
            ) ?? "51.511533,-0.125112,Covent Garden"
        )
        .coordinates

        let currentTime: Int = Int(NSDate().timeIntervalSince1970)

        if let twoDayDate = UserDefaults.standard.value(forKey: "lastSave2Day") {
            lastSave = Int(String(describing: twoDayDate)) ?? 743
            if currentTime - lastSave >= 300 || lastSaveJSON5Day == "Error" {
                reloadDataTwoDay(locations: locations)
            }
        } else {
            lastSave = Int(NSDate().timeIntervalSince1970)
            reloadDataTwoDay(locations: locations)
        }

        if let fiveDayDate = UserDefaults.standard.value(forKey: "lastSave5Day") {
            lastSave = Int(String(describing: fiveDayDate)) ?? 743
            if currentTime - lastSave >= 3600 || lastSaveJSON5Day == "Error" {
                reloadDataFiveDay(locations: locations)
            }
        } else {
            lastSave = Int(NSDate().timeIntervalSince1970)
            reloadDataFiveDay(locations: locations)
        }
    }

    mutating func reloadDataTwoDay(locations: [Location]) {
        for location in locations {
            let twoDayURL: String = "https://api.openweathermap.org/data/2.5/onecall?"

            guard let twoDayUrl = URL(
                string: constructURL(twoDayURL, location.urlVersion)
            ) else {
                throwNSAlert(
                    messageText: "There was an error gathering weather data in the background.",
                    severity: .warning
                )
                return
            }

            do {
                let twoDayContents: String = try String(contentsOf: twoDayUrl, encoding: .ascii)
                let unixEpoch: Int = Int(NSDate().timeIntervalSince1970)
                lastSaveJSON2Day = twoDayContents

                DispatchQueue.global(qos: .background).async {
                    UserDefaults.standard.set(
                        unixEpoch,
                        forKey: "lastSave2Day"
                    )
                    UserDefaults.standard.set(
                        twoDayContents,
                        forKey: "weatherSave2Day"
                    )
                }
            } catch {
                throwNSAlert(
                    messageText: "There was an error gathering weather data in the background.",
                    severity: .warning
                )
            }
        }
    }

    mutating func reloadDataFiveDay(locations: [Location]) {
        for location in locations {
            let fiveDayURL: String = "https://api.openweathermap.org/data/2.5/forecast?"

            guard let fiveDayUrl = URL(
                string: constructURL(fiveDayURL, location.urlVersion)
            ) else {
                throwNSAlert(
                    messageText: "There was an error gathering weather data in the background.",
                    severity: .warning
                )
                return
            }

            do {
                let fiveDayContents: String = try String(contentsOf: fiveDayUrl, encoding: .ascii)
                let unixEpoch: Int = Int(NSDate().timeIntervalSince1970)
                lastSaveJSON5Day = fiveDayContents

                DispatchQueue.global(qos: .background).async {
                    UserDefaults.standard.set(
                        fiveDayContents,
                        forKey: "weatherSave5Day"
                    )
                    UserDefaults.standard.set(
                        unixEpoch,
                        forKey: "lastSave5Day"
                    )
                }
            } catch {
                throwNSAlert(
                    messageText: "There was an error gathering weather data in the background.",
                    severity: .warning
                )
            }
        }
    }
}

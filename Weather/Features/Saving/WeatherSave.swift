//
//  WeatherSave.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 11/06/23.
//

import Foundation

struct WeatherSave {
    var twoDay: [WeatherSaveInstance], fiveDay: [WeatherSaveInstance]

    init() {
        twoDay = []; fiveDay = []

        reloadAll()
    }

    private mutating func decodeFromUserDefaults() -> [Int] {
        var lowestTime2Day: Int = Int(Date().timeIntervalSince1970) + 1
        var lowestTime5Day: Int = Int(Date().timeIntervalSince1970) + 1
        let weatherSave2Day: String = UserDefaults.standard.string(
            forKey: "weatherSave2Day"
        ) ?? "51.511533,-0.125112,Covent Garden|"
        let weatherSave5Day: String = UserDefaults.standard.string(
            forKey: "weatherSave5Day"
        ) ?? "51.511533,-0.125112,Covent Garden|"

        for instance in weatherSave2Day.split(separator: "|") {
            let splittedInstance = instance.toString().split(separator: ",")
            let timeRep: Int = Int(splittedInstance[2].toString())!

            if timeRep < Int(lowestTime2Day) {
                lowestTime2Day = Int(timeRep)
            }

            twoDay.append(
                WeatherSaveInstance(
                    jsonContent: splittedInstance[0].toString().replacingOccurrences(
                        of: "'''",
                        with: ""
                    ),
                    urlContent: splittedInstance[1].toString()
                )
            )
        }

        for instance2 in weatherSave5Day.split(separator: "|") {
            let splittedInstance = instance2.toString().split(separator: ",")
            let timeRep: Int = Int(splittedInstance[2].toString())!

            if timeRep < Int(lowestTime5Day) {
                lowestTime5Day = Int(timeRep)
            }
            twoDay.append(
                WeatherSaveInstance(
                    jsonContent: splittedInstance[0].toString().replacingOccurrences(
                        of: "'''",
                        with: ""
                    ),
                    urlContent: splittedInstance[1].toString()
                )
            )
        }

        return [lowestTime2Day, lowestTime5Day]
    }

    func encode(time: Int) {
        UserDefaults.standard.set(
            "",
            forKey: "weatherSave2Day"
        )
        UserDefaults.standard.set(
            "",
            forKey: "weatherSave5Day"
        )
        var twoDayString: String = "", fiveDayString: String = ""

        for hour in twoDay {
            twoDayString += "'''\(hour.json)''',\(hour.url),\(time)"
        }

        for hour2 in fiveDay {
            fiveDayString += "'''\(hour2.json)''',\(hour2.url),\(time)"
        }

        UserDefaults.standard.set(
            twoDayString,
            forKey: "weatherSave2Day"
        )

        UserDefaults.standard.set(
            fiveDayString,
            forKey: "weatherSave5Day"
        )
    }

    private func getLocations() -> [Location] {
        return Locations(
            fromString: UserDefaults.standard.string(forKey: "locations") ?? "51.511533,-0.125112,Covent Garden|"
        )
        .coordinates
    }

    mutating func reloadTwoDay() {
        for location in getLocations() {
            let twoDayURL: String = constructURL(
                "https://api.openweathermap.org/data/2.5/onecall?",
                location.urlVersion
            )

            guard let twoDayUrl = URL(string: twoDayURL) else {
                throwNSAlert(
                    messageText: "There was an error gathering weather data in the background.",
                    severity: .warning
                )
                return
            }

            do {
                twoDay.append(
                    WeatherSaveInstance(
                        jsonContent: try String(contentsOf: twoDayUrl, encoding: .ascii),
                        urlContent: twoDayURL
                    )
                )

                encode(time: Int(Date().timeIntervalSince1970))
            } catch {
                throwNSAlert(
                    messageText: "There was an error gathering weather data in the background.",
                    severity: .warning
                )
            }
        }
    }

    mutating func reloadFiveDay() {
        for location in getLocations() {
            let fiveDayURL: String = constructURL(
                "https://api.openweathermap.org/data/2.5/forecast?",
                location.urlVersion
            )

            guard let fiveDayUrl = URL(string: fiveDayURL) else {
                throwNSAlert(
                    messageText: "There was an error gathering weather data in the background.",
                    severity: .warning
                )
                return
            }

            do {
                fiveDay.append(
                    WeatherSaveInstance(
                        jsonContent: try String(contentsOf: fiveDayUrl, encoding: .ascii),
                        urlContent: fiveDayURL
                    )
                )

                encode(time: Int(Date().timeIntervalSince1970))
            } catch {
                throwNSAlert(
                    messageText: "There was an error gathering weather data in the background.",
                    severity: .warning
                )
            }
        }
    }

    // TODO: Add support for reloading only one url
    mutating func reloadAll() {
        reloadTwoDay()
        reloadFiveDay()
    }
}

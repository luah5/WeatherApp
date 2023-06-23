//
//  WeatherSave.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 11/06/23.
//

import Foundation

struct WeatherSave {
    var twoDay: [WeatherSaveInstance], fiveDay: [WeatherSaveInstance]

    init(_ shouldReload: Bool = false) {
        twoDay = []; fiveDay = []

        if shouldReload {
            reloadAll()
        }
        decodeFromUserDefaults()
    }

    private mutating func decodeFromUserDefaults() {
        let maxTime2Day: Int = 300; let maxTime5Day: Int = 1800
        let currentTime: Int = Int(Date().timeIntervalSince1970)
        let weatherSave2Day: String = UserDefaults.standard.string(
            forKey: "weatherSave2Day"
        ) ?? "Error,Error,0|"
        let weatherSave5Day: String = UserDefaults.standard.string(
            forKey: "weatherSave5Day"
        ) ?? "Error,Error,0|"

        for instance in weatherSave2Day.split(separator: "|") {
            let splittedInstance1 = instance.toString().split(separator: "'''")
            let splittedInstance2 = splittedInstance1[1].split(separator: ",")

            if currentTime - Int(splittedInstance2[1].toString())! >= maxTime2Day {
                reloadURL(url: splittedInstance2[0].toString())
            }

            twoDay.append(
                WeatherSaveInstance(
                    jsonContent: splittedInstance1[0].toString().replacingOccurrences(
                        of: "'''",
                        with: ""
                    ),
                    urlContent: splittedInstance2[0].toString()
                )
            )
        }

        for instance2 in weatherSave5Day.split(separator: "|") {
            let splittedInstance1 = instance2.toString().split(separator: "'''")
            let splittedInstance2 = splittedInstance1[1].split(separator: ",")

            if currentTime - Int(splittedInstance2[1].toString())! >= maxTime5Day {
                reloadURL(url: splittedInstance2[0].toString())
            }

            fiveDay.append(
                WeatherSaveInstance(
                    jsonContent: splittedInstance1[0].toString().replacingOccurrences(
                        of: "'''",
                        with: ""
                    ),
                    urlContent: splittedInstance2[0].toString()
                )
            )
        }
    }

    func encode() {
        let time: Int = Int(Date().timeIntervalSince1970)
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
            twoDayString += "'''\(hour.json)''',\(hour.url),\(time)|"
        }

        for hour2 in fiveDay {
            fiveDayString += "'''\(hour2.json)''',\(hour2.url),\(time)|"
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

                encode()
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

                encode()
            } catch {
                throwNSAlert(
                    messageText: "There was an error gathering weather data in the background.",
                    severity: .warning
                )
            }
        }
    }

    mutating func reloadURL(url: String) {
        let weatherSave2Day: String = UserDefaults.standard.string(
            forKey: "weatherSave2Day"
        ) ?? "Error,Error,0|"
        let weatherSave5Day: String = UserDefaults.standard.string(
            forKey: "weatherSave5Day"
        ) ?? "Error,Error,0|"

        for instance in weatherSave2Day.split(separator: "|") where instance.split(separator: ",")[1] == url {
            do {
                twoDay.append(
                    WeatherSaveInstance(
                        jsonContent: try String(contentsOf: URL(string: url)!, encoding: .ascii),
                        urlContent: url
                    )
                )
                self.encode()

                return
            } catch {
                throwNSAlert(messageText: "reloadURL(url: \(url)) failed.", severity: .warning)
            }
        }

        for instance in weatherSave5Day.split(separator: "|") where instance.split(separator: ",")[1] == url {
            do {
                fiveDay.append(
                    WeatherSaveInstance(
                        jsonContent: try String(contentsOf: URL(string: url)!, encoding: .ascii),
                        urlContent: url
                    )
                )
                self.encode()
            } catch {
                throwNSAlert(messageText: "reloadURL(url: \(url)) failed.", severity: .warning)
            }
        }
    }

    mutating func reloadAll() {
        reloadTwoDay()
        reloadFiveDay()
    }
}

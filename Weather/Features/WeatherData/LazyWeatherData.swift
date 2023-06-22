//
//  LazyWeatherData.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 22/06/23.
//

import Foundation

struct LazyWeatherData {
    let background: IconImage

    init() {
        let weatherSave: String = UserDefaults.standard.string(
            forKey: "weatherSave2Day"
        )!
        let selection: Int = UserDefaults.standard.integer(forKey: "selection")
        var index: Int = 0
        var json: JSON = .null

        for instance in weatherSave.split(separator: "|") {
            if index == selection {
                json = JSON(
                    parseJSON: instance.toString()
                        .split(separator: "'''")[0].toString()
                        .replacingOccurrences(of: "'''", with: "")
                )
            }

            index += 1
        }
        print(json["current"], "cool")
        self.background = json["current"]["weather"][0]["icon"].stringValue.iconToBackground()
    }
}

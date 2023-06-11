//
//  WeatherSaveInstance.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 11/06/23.
//

import Foundation

struct WeatherSaveInstance {
    var json: JSON, url: String

    init(jsonContent: String, urlContent: String) {
        self.json = JSON(parseJSON: jsonContent)
        self.url = urlContent
    }
}

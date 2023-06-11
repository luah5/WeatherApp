//
//  WeatherAlert.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 12/05/23.
//

import Foundation

struct WeatherAlert {
    var senderName: String, event: String, description: String, type: String
    var startTime: Int, endTime: Int

    init(json: JSON) {
        senderName = json["sender_name"].stringValue
        event = json["event"].stringValue
        description = json["description"].stringValue
        type = json["type"].stringValue

        startTime = Int(json["start"].stringValue) ?? 100
        endTime = Int(json["end"].stringValue) ?? 100
    }
}

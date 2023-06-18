//
//  WeatherAlert.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 12/05/23.
//

import Foundation

struct WeatherAlert: Identifiable {
    let senderName: String, event: String, description: String, type: String
    let startTime: Int, endTime: Int
    let id: UUID = UUID()

    init(json: JSON) {
        self.senderName = json["sender_name"].stringValue
        self.event = json["event"].stringValue
        self.description = json["description"].stringValue
        self.type = json["type"].stringValue

        self.startTime = Int(json["start"].stringValue) ?? 100
        self.endTime = Int(json["end"].stringValue) ?? 100
    }
}

//
//  TemperatureDaily.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 27/05/23.
//

import Foundation
import SwiftyJSON

struct TemperatureDaily {
    var morning: Float, day: Float, evening: Float, night: Float
    var min: Float, max: Float

    init(json: JSON) {
        morning = Float(json["morn"].stringValue) ?? 0
        day = Float(json["day"].stringValue) ?? 0
        evening = Float(json["eve"].stringValue) ?? 0
        night = Float(json["night"].stringValue) ?? 0

        min = Float(json["min"].stringValue) ?? 0
        max = Float(json["max"].stringValue) ?? 0
    }
}

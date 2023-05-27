//
//  FeelsLikeDaily.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 27/05/23.
//

import Foundation
import SwiftyJSON

struct FeelsLikeDaily {
    var morning: Float, day: Float, evening: Float, night: Float

    init(json: JSON) {
        morning = Float(json["morn"].stringValue) ?? 0
        day = Float(json["day"].stringValue) ?? 0
        evening = Float(json["eve"].stringValue) ?? 0
        night = Float(json["night"].stringValue) ?? 0
    }
}

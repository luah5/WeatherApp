//
//  Location.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 13/05/23.
//

import Foundation
import MapKit

struct Location: Hashable {
    var lat: Double, lon: Double, urlVersion: String, locationString: String

    init(lat: Double, lon: Double, location: String) {
        self.lat = lat
        self.lon = lon
        self.urlVersion = "lat=\(lat)&lon=\(lon)"
        self.locationString = location
    }

    init(location: CLLocationCoordinate2D, location2: String) {
        self.lat = location.latitude
        self.lon = location.longitude
        self.urlVersion = "lat=\(lat)&lon=\(lon)"
        self.locationString = location2
    }
}

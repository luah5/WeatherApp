//
//  Location.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 13/05/23.
//

import Foundation
import CoreLocation
import MapKit

struct Location {
    var lat: Double, lon: Double, urlVersion: String

    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
        self.urlVersion = "lat=\(lat)&lon=\(lon)"
    }

    init(location: CLLocationCoordinate2D) {
        self.lat = location.latitude
        self.lon = location.longitude
        self.urlVersion = "lat=\(lat)&lon=\(lon)"
    }
}
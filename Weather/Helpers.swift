//
//  Helpers.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 17/04/23.
//

import Foundation
import SwiftUI
import CoreLocation

/// Returns the current time.
func getTime() -> String {
    let formatter: DateFormatter = DateFormatter()
    formatter.timeStyle = .short

    return formatter.string(from: Date())
}

/// An enum for the current pollen level
enum PollenLevel: String {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    case veryHigh = "Very High"
}

/// Gets the current city at latitude 37.7749 and longitude: -122.4194
func getCurrentCity() -> String {
    // Create a CLLocation object from the latitude and longitude coordinates
    let location = CLLocation(latitude: 37.7749, longitude: -122.4194)

    // Create a CLGeocoder object
    let geocoder = CLGeocoder()

    var returnText: String = "London"

    // Use the geocoder to get the nearest placemark
    geocoder.reverseGeocodeLocation(location) { placemarks, error in
        guard error == nil else {
            returnText = "London"
            return
        }

        // Get the first placemark
        guard let placemark = placemarks?.first else {
            returnText = "London"
            return
        }

        // Get the city from the placemark
        if let city = placemark.locality {
            returnText = city.replacingOccurrences(of: " ", with: "%20").lowercased()
        } else {
            returnText = "London"
            return
        }
    }

    return returnText
}

func convertAddressToPlacemark(_ address: String) -> [CLPlacemark] {
    var placemarks: [CLPlacemark] = []

    CLGeocoder().geocodeAddressString(address) { CLPlacemarks, _ in
        if (CLPlacemarks?.count ?? 0) >= 1 {
            placemarks = CLPlacemarks!
        }

        let lat = CLPlacemarks?.first?.location?.coordinate.latitude
        let lon = CLPlacemarks?.first?.location?.coordinate.longitude
        print("Lat: \(String(describing: lat)), Lon: \(String(describing: lon))")
    }

    return placemarks
}

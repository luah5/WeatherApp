//
//  Helpers.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 17/04/23.
//

import Foundation
import SwiftUI

/// Returns the current time.
func getTime() -> String {
    let formatter: DateFormatter = DateFormatter()
    formatter.timeStyle = .short

    return formatter.string(from: Date())
}

func getAddressFromCoordinates(location: Location) -> String {
    let lat: Double = location.lat
    let lon: Double = location.lon

    let url: String = "https://geocode.maps.co/reverse?lat=\(lat)&lon=\(lon)"

    guard let url = URL(string: url) else {
        fatalError()
    }

    do {
        let contents: String = try String(contentsOf: url)
        let address = JSON(parseJSON: contents)["address"]

        if address["city"].exists() {
            return address["city"].stringValue
        } else if address["state"].exists() {
            return address["state"].stringValue
        } else if address["state_district"].exists() {
            return address["state_district"].stringValue
        } else if address["postcode"].exists() {
            return address["postcode"].stringValue
        } else if address["road"].exists() {
            return address["road"].stringValue
        } else if address["country"].exists() {
            return address["country"].stringValue
        }
    } catch {
        fatalError()
    }

    return "Error"
}

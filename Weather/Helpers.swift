//
//  Helpers.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 17/04/23.
//

import Foundation
import SwiftUI
import SwiftyJSON

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
        let contents: Data = try String(contentsOf: url, encoding: .utf8).data(using: .utf8)!

        let address: JSON = try JSON(data: contents)["address"]
        let start = address["road"].stringValue + ", " + address["city"].stringValue

        return start + ", " + address["state"].stringValue
    } catch {
        fatalError()
    }
}

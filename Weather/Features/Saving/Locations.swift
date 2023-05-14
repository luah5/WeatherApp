//
//  Locations.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 14/05/23.
//

import Foundation

struct Locations {
    var coordinates: [Location]

    init(coordinates: [Location]) {
        self.coordinates = coordinates
    }

    init(fromString: String) {
        var splitted: [Substring] = fromString.split(separator: "|")
        coordinates = []

        for split in splitted {
            let furtherSplit = split.split(separator: ",")
            coordinates.append(
                Location(
                    lat: Double(furtherSplit[0]) ?? 0,
                    lon: Double(furtherSplit[1]) ?? 0
                )
            )
        }
    }

    func encode() -> String {
        var output: String = ""

        for coordinate in coordinates {
            output += "\(coordinate.lat),\(coordinate.lon)|"
        }

        return output
    }
}

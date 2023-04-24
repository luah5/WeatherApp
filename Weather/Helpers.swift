//
//  Helpers.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 17/04/23.
//

import Foundation
import SwiftUI
import CoreLocation

func getTime() -> String {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    let dateString = formatter.string(from: Date())
    return dateString
}

func getCurrentCity() -> String {
    // Create a CLLocation object from the latitude and longitude coordinates
    let location = CLLocation(latitude: 37.7749, longitude: -122.4194)

    // Create a CLGeocoder object
    let geocoder = CLGeocoder()

    var returnText: String = "London"

    // Use the geocoder to get the nearest placemark
    geocoder.reverseGeocodeLocation(location) { placemarks, error in
        guard error == nil else {
            print("Error: \(error!.localizedDescription)")
            returnText = "London"
            return
        }

        // Get the first placemark
        guard let placemark = placemarks?.first else {
            print("No placemarks found.")
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

@ViewBuilder
/// Generates a View from given values
func temperatureDetailView(day: WeatherDay) -> some View {
    let timestamp = day.weatherHours[0].time.toTimestamp().split(separator: " ")
    @State var showConnectionAlert = false
    VStack {
        HStack(spacing: 30) {
            Text(timestamp[0] + "th")
                .font(.system(size: 14, weight: .semibold))
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.red)
                .fixedSize()
            Text("\(day.minTemp.toInt())º")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)
            HStack(spacing: 0) {
                PreviewColor(.gray, width: 60)
                PreviewColor(.yellow, width: 10)
                PreviewColor(.blue, width: 10)
                PreviewColor(.white, width: 10)
                PreviewColor(.yellow, width: 10)
            }
            .clipShape(Capsule())
            .overlay {
                Capsule()
                    .stroke(Color(.white).opacity(0.15), lineWidth: 0.5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            Text("\(day.maxTemp.toInt())º")
                .font(.system(size: 14, weight: .semibold))
                .padding(.trailing)
                .frame(alignment: .trailing)
        }
        .frame(alignment: .center)

        ScrollView(.horizontal) {
            HStack {
                Divider()

                ForEach(day.weatherHours, id: \.time) { hour in
                    let split = hour.time.toTimestamp().split(separator: " ")

                    VStack {
                        Text(split[split.count - 1])
                        hour.weather.icon
                        Text("\(hour.temp.toInt())º")
                    }
                    .frame(width: 45, height: 50)

                    Divider()
                }
            }
            .frame(alignment: .center)
        }
        .frame(height: 50)
    }
}

struct PreviewColor: View {
    private var color: Color
    private var width: CGFloat

    init(_ color: Color, width: CGFloat) {
        self.color = color
        self.width = width
    }

     var body: some View {
        color
            .frame(width: width, height: 5)
            .cornerRadius(5)
    }
}

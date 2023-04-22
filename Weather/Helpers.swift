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

// swiftlint:disable force_cast force_try
func getJsonObject(string: String) -> [String: Any] {
    do {
        return try! JSONSerialization.jsonObject(with: string.data(using: .utf8)!) as! [String: Any]
    }
}

func getJSONObject(string: String) -> Any {
    do {
        return try! JSONSerialization.jsonObject(with: string.data(using: .utf8)!, options: .fragmentsAllowed)
    }
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

func getWeatherData() -> Any {
    let baseURL = "https://api.openweathermap.org/data/2.5/weather?q="
    let url = "\(baseURL)\(getCurrentCity())&appid=59b882df8e35c2c5eefe87e105b2d6df&units=metric"

    guard let myURL = URL(string: url) else {
        return "error"
    }

    do {
        let contents = try String(contentsOf: myURL, encoding: .ascii)
        let product = getJsonObject(string: contents)

        _ = String(describing: product["main"] ?? "none")
            .replacingOccurrences(of: ";", with: "")
            .replacingOccurrences(of: "\n", with: " = ")
            .split(separator: " = ")
        return WeatherData(product: product)
    } catch let error {
        print("error")
        return error
    }
}

/// A structure for holding weather data, intialization of values is handled within the init function
struct WeatherData {
    var humidity: Int, temp: Int, minTemp: Int, maxTemp: Int, feelsLike: Int, pressure: Int
    var description: String, icon: String

    init(product: [String: Any]) {
        let mainData = String(describing: product["main"])
            .replacingOccurrences(of: ";", with: "")
            .replacingOccurrences(of: "\n", with: " = ")
            .split(separator: " = ")

        let descriptionData = String(describing: product["weather"])
            .replacingOccurrences(of: ";", with: "")
            .replacingOccurrences(of: "\n", with: " = ")
            .split(separator: " = ")

        self.description = String(describing: descriptionData[3].removeQuotationMarks()).capitalized
        self.icon = String(describing: descriptionData[9])

        self.feelsLike = Int(Double(mainData[2].removeQuotationMarks()) ?? 1.0)
        self.humidity = Int(mainData[4]) ?? 0
        self.pressure = Int(mainData[6]) ?? 0
        self.temp = Int(Double(mainData[8].removeQuotationMarks()) ?? 1.0)

        self.maxTemp = Int(Double(mainData[10].removeQuotationMarks()) ?? 1.0)
        self.minTemp = Int(Double(mainData[12].removeQuotationMarks()) ?? 1.0)
    }
}

@ViewBuilder
func timeView(time: String, weather: String, temp: Int) -> some View {
    VStack {
        Text(time)
        if weather == "Sun" {
            Image(systemName: "sun.max.fill")
                .foregroundColor(.yellow)
                .fixedSize()
        } else if weather == "Cloudy" {
            Image(systemName: "cloud")
                .foregroundColor(.gray)
                .fixedSize()
        } else if weather == "Partly Cloudy" {
            Image(systemName: "cloud.sun.fill")
                .foregroundColor(.gray)
                .fixedSize()
        } else if weather == "Clear" {
            Image(systemName: "moon.fill")
                .foregroundColor(.gray)
                .fixedSize()
        } else {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.red)
                .fixedSize()
        }
        Text("\(temp)º")
    }
}

@ViewBuilder
// swiftlint:disable function_body_length
/// Generates a View from given values
func temperatureDetailView(day: String, weather: String, minTemp: Int, maxTemp: Int) -> some View {
    VStack {
        HStack(spacing: 30) {
            Text("\(day)")
                .font(.system(size: 14, weight: .semibold))

            if weather == "Sun" {
                Image(systemName: "sun.max.fill")
                    .foregroundColor(.yellow)
                    .fixedSize()
            } else if weather == "Cloudy" {
                Image(systemName: "cloud")
                    .foregroundColor(.gray)
                    .fixedSize()
            } else if weather == "Partly Cloudy" {
                Image(systemName: "cloud.sun.fill")
                    .foregroundColor(.gray)
                    .fixedSize()
            } else if weather == "Clear" {
                Image(systemName: "moon.fill")
                    .foregroundColor(.gray)
                    .fixedSize()
            } else {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.red)
                    .fixedSize()
            }
            Text("\(minTemp)º")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)
                .opacity(0.6)
            let maxRoundedTemp = ceil(round(CGFloat(maxTemp * 5)) / 5)
            let minRoundedTemp = floor(round(CGFloat(minTemp * 5)) / 5)
            let range = maxRoundedTemp - minRoundedTemp
            let width = (range / (range - (CGFloat(minTemp) - minRoundedTemp))) * 10
            let multiplication = (100 - width) / maxRoundedTemp
            HStack(spacing: 0) {
                PreviewColor(.gray, width: width)
                PreviewColor(.yellow, width: (CGFloat(maxTemp) * multiplication) - 5)
                PreviewColor(.blue, width: maxRoundedTemp)
                PreviewColor(.white, width: 5)
                PreviewColor(.yellow, width: 95 - (width + (CGFloat(maxTemp) * multiplication) - 5))
            }
            .clipShape(Capsule())
            .overlay {
                Capsule()
                    .stroke(Color(.white).opacity(0.15), lineWidth: 0.5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            Text("\(maxTemp)º")
                .font(.system(size: 14, weight: .semibold))
                .padding(.trailing)
                .frame(alignment: .trailing)
        }

        HStack {
            Group {
                timeView(time: "0:00", weather: "Clear", temp: 6)
                Divider()
                timeView(time: "1:00", weather: "Clear", temp: 3)
                Divider()
                timeView(time: "2:00", weather: "Clear", temp: 13)
                Divider()
            }
            Group {
                timeView(time: "3:00", weather: "Clear", temp: 15)
                Divider()
                timeView(time: "4:00", weather: "Clear", temp: 14)
                Divider()
                timeView(time: "5:00", weather: "Clear", temp: 9)
                Divider()
            }
        }
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
// swiftlint:enable force_cast force_try function_body_length

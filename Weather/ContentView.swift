//
//  ContentView.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 17/04/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            Form {
                Button {
                    getWeatherData()
                } label: {
                    VStack {
                        Text("My Location")
                            .fontWeight(.medium)
                            .padding([.top, .leading])
                        Text(getTime())
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("Partly Cloudy")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                    .padding(.leading)
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
            }
            .formStyle(.grouped)
        } detail: {
            Spacer()
            VStack(spacing: 0) {
                Text("London")
                    .font(.system(.title))
                Text("13º")
                    .font(.system(size: 56, weight: .thin))
                Text("Mostly Sunny")
                    .font(.system(.headline, weight: .semibold))
                Text(getTime())
                    .font(.system(.headline, weight: .semibold))
            }
            Form {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.secondary)
                    Text("Next 10 days of weather")
                        .foregroundColor(.secondary)
                }
                temperatureDetailView(day: "17th", weather: "Rain", minTemp: 8, maxTemp: 17)
                temperatureDetailView(day: "18th", weather: "Run", minTemp: 2, maxTemp: 13)
                temperatureDetailView(day: "19th", weather: "Sun", minTemp: 11, maxTemp: 18)
            }
            .formStyle(.grouped)
            .background(.opacity(0.2))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

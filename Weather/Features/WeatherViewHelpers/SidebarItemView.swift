//
//  SidebarItemView.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 02/06/23.
//

import Foundation
import SwiftUI

struct SidebarItemView: View {
    var item: WeatherMainView, weatherForecast: WeatherForecast
    @State private var dataSave: DataSave = DataSave()

    init(weatherItem: WeatherMainView) {
        item = weatherItem
        weatherForecast = item.weatherForecast
    }

    var body: some View {
        NavigationLink {
            item
                .background(
                    weatherForecast.current.weather.background.image
                        .scaledToFill()
                )
        } label: {
            VStack(spacing: 25) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(weatherForecast.address)
                            .fontWeight(.medium)
                            .font(.system(.title))
                            .help(weatherForecast.address)
                        Text(weatherForecast.current.time.toTimestamp3())
                    }

                    Spacer()

                    VStack(alignment: .trailing) {
                        Text("\(String(weatherForecast.current.temp))º")
                            .font(.system(.title))
                        Text("""
H: \(String(weatherForecast.today.maxTemp))º L: \(String(weatherForecast.today.maxTemp))º
""")
                    }
                }
            }
        }
    }
}

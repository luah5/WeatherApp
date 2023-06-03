//
//  SidebarItemView.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 02/06/23.
//

import Foundation
import SwiftUI

struct SidebarItemView: View {
    var item: WeatherMainView, weatherForecast: WeatherForecast, weatherDay: WeatherDayDaily
    @State private var dataSave: DataSave = DataSave()

    init(weatherItem: WeatherMainView) {
        item = weatherItem
        weatherForecast = item.weatherForecast
        weatherDay = weatherForecast.today.weatherDayDaily
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
                            .font(.system(.title3))
                            .help(weatherForecast.address)
                        Text(weatherForecast.current.time.toTimestamp3())
                        Text(weatherForecast.current.weather.description.capitalized)
                    }

                    Spacer()

                    VStack(alignment: .trailing) {
                        Text("\(weatherForecast.current.temp.toInt().toString())º")
                            .font(.system(size: 30))
                            .fontWeight(.thin)
                        Spacer()
                        Text("""
H: \(String(weatherDay.temperatureDaily.max))º L: \(String(weatherDay.temperatureDaily.min))º
""")
                    }
                }
                .frame(alignment: .top)
            }
        }
    }
}
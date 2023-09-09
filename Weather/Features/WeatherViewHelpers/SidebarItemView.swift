//
//  SidebarItemView.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 02/06/23.
//

import Foundation
import SwiftUI

struct SidebarItemView: View {
    init(
        forecast: WeatherForecast,
        selection: Int,
        dataSave: DataSave
    ) {
        self.weatherForecast = forecast
        self.weatherDay = weatherForecast.today.weatherDayDaily
        self.selection = selection
        self.dataSave = dataSave
    }

    let selection: Int
    let weatherForecast: WeatherForecast
    let weatherDay: WeatherDayDaily
    @ObservedObject var dataSave: DataSave

    var body: some View {
        NavigationLink(value: selection) {
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
H: \(weatherDay.temperatureDaily.max.toInt().toString())º L: \(weatherDay.temperatureDaily.min.toInt().toString())º
""")
                    }
                }
                .frame(alignment: .top)
            }
        }
    }
}

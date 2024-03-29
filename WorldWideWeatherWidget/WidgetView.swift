//
//  WidgetView.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 06/06/23.
//

import SwiftUI

struct LazyDataSave {
    var data: WeatherData

    init() {
        data = WeatherData(
            json: WeatherSave(.positive).twoDay.first!.json
        )
    }
}

struct WidgetView: View {
    @State private var data: WeatherData = LazyDataSave().data

    var body: some View {
        HStack {
            Text("  ")

            VStack(alignment: .leading) {
                Text("")

                Text(data.location)
                    .font(.system(.title3))
                    .bold()
                Text("\(data.hours.first!.temp.toInt().toString())º")

                Text("")

                data.hours.first!.weather.icon.image
                    .frame(width: 50, height: 50)
                    .offset(x: -10)
                Text(data.hours.first!.weather.description.localizedCapitalized)
                    .bold()
                Text("L: -128º H: 128º")

                Spacer()
            }
            .background(
                data.hours.first!.weather.background.image
                    .scaledToFill()
            )
            .frame(maxHeight: .infinity)

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(
            data.hours.first!.weather.background.image
                .scaledToFill()
        )
    }
}

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
        data = getHourlyWeatherData(
            location: Locations(
                fromString: UserDefaults.standard.string(
                        forKey: "locations"
                    ) ?? "51.511533,-0.125112,Covent"
            )
            .coordinates
            .first!
        )
    }
}

struct WidgetView: View {
    @State private var data: WeatherData = LazyDataSave().data

    var body: some View {
        VStack {
            Text(data.location)
                .font(.system(.title3))
                .bold()
            Text("\(data.hours.first!.temp.toInt().toString())º")
        }
        .background(
            data.hours.first!.weather.background.image
                .scaledToFill()
        )
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView()
    }
}

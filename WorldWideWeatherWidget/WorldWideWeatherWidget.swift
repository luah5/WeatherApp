//
//  WorldWideWeatherWidget.swift
//  WorldWideWeatherWidget
//
//  Created by Raymond Vleeshouwer on 06/06/23.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (SimpleEntry) -> Void
    ) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (Timeline<Entry>) -> Void
    ) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct WorldWideWeatherWidgetEntryView: View {
    var body: some View {
        WidgetView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

@main
struct WorldWideWeatherWidget: Widget {
    let kind: String = "WorldWideWeatherWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { _ in
            WorldWideWeatherWidgetEntryView()
        }
        .configurationDisplayName("Weather forecast")
        .description("Current weather forecast.")
        .supportedFamilies([.systemSmall])
    }
}

struct WorldWideWeatherWidget_Previews: PreviewProvider {
    static var previews: some View {
        WorldWideWeatherWidgetEntryView()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

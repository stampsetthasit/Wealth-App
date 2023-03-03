//
//  WeathWidget.swift
//  WeathWidget
//
//  Created by Yadar Tulayathamrong on 2/3/2566 BE.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
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

extension Date {
    var dateFormat : String {
        self.formatted(
            .dateTime.weekday().day().month()
        )
    }
}

struct WeathWidgetEntryView : View {
    var entry: SimpleEntry

    var body: some View {
        ZStack{
        ContainerRelativeShape()
                .fill(
                        LinearGradient(
                           gradient: Gradient(colors: [Color("Purpil"),Color("Yelliw")]),
                           startPoint: .top,
                           endPoint: .bottom)
                )
            Text(entry.date.dateFormat)
                .foregroundColor(Color.white)
                .font(.system(size:16, weight: .bold, design: .rounded))
        }
    }
}

struct WeathWidget: Widget {
    let kind: String = "WeathWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WeathWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Weath Widget")
        .description("This widget is based on your current location")
    }
}

struct WeathWidget_Previews: PreviewProvider {
    static var previews: some View {
        WeathWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

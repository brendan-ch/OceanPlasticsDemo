//
//  UpcomingEventsView.swift
//  OceanPlasticsDemo
//
//  Created by Brendan Chen on 2024.03.18.
//

import Foundation
import SwiftUI
import SwiftData

struct UpcomingEventsView: View {
    @Query(sort: \Event.date) var events: [Event]
    
    var body: some View {
        List {
            ForEach(events) { event in
                ZStack {
                    NavigationLink {
                        EventView(event: event)
                    } label: {
                        EmptyView()
                    }
                    .opacity(0.0)
                    CardView(caption: event.nonprofit?.name ?? "", title: event.name, description: event.date.formatted()) {
                        Image(event.imageAssetName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 4.0))
                            .clipped()
                    }
                }
                .listRowInsets(EdgeInsets())
            }
        }
        .listStyle(.plain)
        .navigationTitle("Events")
    }
}

#Preview {
    UpcomingEventsView()
        .modelContainer(PlaceholderDataController.previewContainer)
}

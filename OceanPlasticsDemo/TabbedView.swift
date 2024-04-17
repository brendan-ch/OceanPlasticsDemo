//
//  TabView.swift
//  OceanPlasticsDemo
//
//  Created by Brendan Chen on 2024.03.18.
//

import Foundation
import SwiftUI
import SwiftData

struct TabbedView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            
            NavigationStack {
                UpcomingEventsView()
            }
                .tabItem {
                    Label("Events", systemImage: "calendar.day.timeline.left")
                }
                
        }
    }
}

#Preview {
    return TabbedView()
        .modelContainer(PlaceholderDataController.previewContainer)
}

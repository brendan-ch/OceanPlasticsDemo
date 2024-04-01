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
            
            NavigationStack {
                AccountView()
            }
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle")
                }
                
        }
    }
}

#Preview {
    return TabbedView()
        .modelContainer(PreviewDataController.previewContainer)
}

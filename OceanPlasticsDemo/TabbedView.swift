//
//  TabView.swift
//  OceanPlasticsDemo
//
//  Created by Brendan Chen on 2024.03.18.
//

import Foundation
import SwiftUI

struct TabbedView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            UpcomingEventsView()
                .tabItem {
                    Label("Events", systemImage: "calendar.day.timeline.left")
                }
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle")
                }
                
        }
    }
}

#Preview {
    TabbedView()
}

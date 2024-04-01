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
    let schema = Schema([
        Event.self,
        Nonprofit.self,
    ])
    
    let options = ModelConfiguration(isStoredInMemoryOnly: true)
    
    let container = try! ModelContainer(for: schema, configurations: [options])
    
    container.mainContext.insert(Nonprofit(name: "Surfrider Foundation", following: true, about: "The Surfrider Foundation USA is a U.S. 501 grassroots non-profit environmental organization that works to protect and preserve the world's oceans, waves and beaches. It focuses on water quality, beach access, beach and surf spot preservation, and sustaining marine and coastal ecosystems. (Wikipedia)", externalResources: [], mailingAddress: "P.O. Box 73550, San Clemente, CA 92673"))
    
    return TabbedView()
        .modelContainer(container)
}

//
//  OceanPlasticsDemoApp.swift
//  OceanPlasticsDemo
//
//  Created by Brendan Chen on 2024.03.18.
//

import SwiftUI
import SwiftData

@main
struct OceanPlasticsDemoApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Event.self,
            Nonprofit.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        let container = try! ModelContainer(for: schema, configurations: modelConfiguration)
    
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            TabbedView()
        }
        .modelContainer(sharedModelContainer)
    }
}

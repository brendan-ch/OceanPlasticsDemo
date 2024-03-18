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
            Event.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            TabbedView()
        }
        .modelContainer(sharedModelContainer)
    }
}

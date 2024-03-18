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
        var modelContainer: ModelContainer;

        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
        
        // TO-DO: insert some starter data
        
        return modelContainer
    }()
    
    var body: some Scene {
        WindowGroup {
            TabbedView()
        }
        .modelContainer(sharedModelContainer)
    }
}

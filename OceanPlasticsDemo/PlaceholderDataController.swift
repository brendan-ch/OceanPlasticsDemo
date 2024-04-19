//
//  PreviewDataController.swift
//  OceanPlasticsDemo
//
//  Created by Brendan Chen on 2024.04.01.
//

import Foundation
import SwiftData
import CoreLocation

/// Singleton object for creating placeholder data in SwiftUI previews and the app.
@MainActor
class PlaceholderDataController {
    static let previewContainer: ModelContainer = {
        let schema = Schema([
            Event.self,
            Nonprofit.self,
        ])
        
        let options = ModelConfiguration(isStoredInMemoryOnly: true)
        
        let container = try! ModelContainer(for: schema, configurations: [options])
        
        insertPlaceholderData(container: container)
        
        return container
    }()
    
    static func insertPlaceholderData(container: ModelContainer) {
        // Clear the existing data without clearing schemas
        try! container.mainContext.delete(model: Nonprofit.self)
        try! container.mainContext.delete(model: Event.self)
        
        let surfriderExternalResources: [ExternalResource] = [
            ExternalResource(name: "Website", systemImageName: "arrow.up.right", link: URL(string: "https://surfrider.org")!)
        ]
        
        let surfrider = Nonprofit(name: "Surfrider Foundation", following: true, about: "The Surfrider Foundation USA is a U.S. 501 grassroots non-profit environmental organization that works to protect and preserve the world's oceans, waves and beaches. It focuses on water quality, beach access, beach and surf spot preservation, and sustaining marine and coastal ecosystems. (Wikipedia)", externalResources: surfriderExternalResources, mailingAddress: "P.O. Box 73550, San Clemente, CA 92673", imageAssetName: "surfrider")
        
        container.mainContext.insert(surfrider)
        
        let coastkeeperExternalResources: [ExternalResource] = [
            ExternalResource(name: "Website", systemImageName: "arrow.up.right", link: URL(string: "https://coastkeeper.org")!)
        ]
        
        let coastkeeper = Nonprofit(name: "Orange County Coastkeeper", following: true, about: "Our mission is to protect the region’s water resources so they are swimmable, drinkable and fishable for present and future generations. (Orange County Coastkeeper)", externalResources: coastkeeperExternalResources, mailingAddress: "3151 Airway Ave F#110, Costa Mesa, CA 92626", imageAssetName: "coastkeeper")
        
        container.mainContext.insert(coastkeeper)
        
        // Create an event on April 14th, 2024 at 9:00 AM PST
        let dockweiler = Event(name: "Dockweiler Beach Cleanup", imageAssetName: "dockweiler", date: Date(timeIntervalSince1970: TimeInterval(1713110400)), externalSignupLink: URL(string: "https://surfrider.com")!, bookmarked: false, about: "Join us at one of the largest annual beach cleanups in Southern California! This event is located at Dockweiler Beach, which covers over 3.7 miles and 288 acres of beach, and is situated right next to Los Angeles International Airport. Food and amenities will be provided!", latitude: 33.938803, longitude: -118.440685)
        dockweiler.nonprofit = surfrider
        
        // Create an event on May 5th, 2024 at 9:00 AM PST
        let balboa = Event(name: "Balboa Beach Cleanup", imageAssetName: "balboa", date: Date(timeIntervalSince1970: TimeInterval(1714924800)), externalSignupLink: URL(string: "https://surfrider.org")!, bookmarked: false, about: "Join us at our annual Balboa Beach Cleanup! Located on the beautiful Balboa Peninsula, this event takes place over 2.5 miles of beach. Food and amenities will be provided, or stop by any of the local businesses along the peninsula!", latitude: 33.603251, longitude: -117.910470)
        balboa.nonprofit = surfrider
        
        let huntington = Event(name: "Huntington Beach Cleanup", imageAssetName: "huntington", date: Date(timeIntervalSince1970: TimeInterval(1715443200)), externalSignupLink: URL(string: "https://coastkeeper.org/cleanup-oc/")!, bookmarked: false, about: "Join coastal cleanup day! Every May, coast keepers host 40+ simultaneous trash cleanups. Join us at Pier 9 in Huntington State Beach.", latitude: 33.638454, longitude: -117.975011)
        
        huntington.nonprofit = coastkeeper
        
        container.mainContext.insert(dockweiler)
        container.mainContext.insert(balboa)
        container.mainContext.insert(huntington)
    }
}

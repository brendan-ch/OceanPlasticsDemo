//
//  EventView.swift
//  OceanPlasticsDemo
//
//  Created by Brendan Chen on 2024.03.18.
//

import SwiftUI
import SwiftData

struct EventView: View {
    var event: Event
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // MARK: - Image and title
                Image(event.imageAssetName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 240)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(event.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Button(action: {
                        UIApplication.shared.open(event.externalSignupLink)
                    }) {
                        HStack {
                            Image(systemName: "arrow.up.right")
                            
                            if let baseURL = event.externalSignupLink.baseURL {
                                Text("Sign up on \(baseURL.absoluteString)")
                            } else {
                                Text("Sign up")
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Nonprofit.self, configurations: config)
    
    // Create an event on April 14th, 2024 at 9:00 AM PST
    let dockweiler = Event(name: "Dockweiler Beach Cleanup", imageAssetName: "dockweiler", date: Date(timeIntervalSince1970: TimeInterval(1713110400)), externalSignupLink: URL(string: "https://surfrider.com")!, bookmarked: false, about: "Join us at one of the largest annual beach cleanups in Southern California! This event is located at Dockweiler Beach, which covers over 3.7 miles and 288 acres of beach, and is situated right next to Los Angeles International Airport. Food and amenities will be provided!", latitude: nil, longitude: nil)
    
    return EventView(event: dockweiler)
}

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
                    .clipped()
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(event.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    // MARK: - Supplementary info
                    
                    if let nonprofit = event.nonprofit {
                        NavigationLink {
                            NonprofitView(nonprofit: nonprofit)
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Hosted by".uppercased())
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .foregroundStyle(.secondary)
                                    Text(nonprofit.name)
                                }
                                Spacer()
                            }
                        }
                        .tint(.primary)
                    }
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("On".uppercased())
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundStyle(.secondary)
                            Text(event.date.formatted())
                        }
                        Spacer()
                    }
                    
                    // MARK: - Call to actions
                    
                    Button(action: {
                        UIApplication.shared.open(event.externalSignupLink)
                    }) {
                        HStack {
                            Spacer()
                            
                            Image(systemName: "arrow.up.right")
                            
                            if let baseURL = event.externalSignupLink.baseURL {
                                Text("Sign up on \(baseURL.absoluteString)")
                                    .fontWeight(.medium)
                            } else {
                                Text("Sign up")
                                    .fontWeight(.medium)
                            }
                            
                            Spacer()
                        }
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    
                    HStack {
                        Button {
                            event.bookmarked.toggle()
                        } label: {
                            HStack {
                                Spacer()
                                if event.bookmarked {
                                    Image(systemName: "bookmark.fill")
                                    Text("Remove")
                                } else {
                                    Image(systemName: "bookmark")
                                    Text("Save")
                                }
                                Spacer()
                            }
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                        
                        Button {
//                            event.bookmarked.toggle()
                        } label: {
                            HStack {
                                Spacer()
                                Image(systemName: "calendar")
                                Text("Add Event")
                                Spacer()
                            }

                        }
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                        
                    }
                }
                .padding()
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Nonprofit.self, configurations: config)
    
    // Create an event on April 14th, 2024 at 9:00 AM PST
    let dockweiler = Event(name: "Dockweiler Beach Cleanup", imageAssetName: "dockweiler", date: Date(timeIntervalSince1970: TimeInterval(1713110400)), externalSignupLink: URL(string: "https://surfrider.com")!, bookmarked: false, about: "Join us at one of the largest annual beach cleanups in Southern California! This event is located at Dockweiler Beach, which covers over 3.7 miles and 288 acres of beach, and is situated right next to Los Angeles International Airport. Food and amenities will be provided!", latitude: nil, longitude: nil)
    
    return EventView(event: dockweiler)
}

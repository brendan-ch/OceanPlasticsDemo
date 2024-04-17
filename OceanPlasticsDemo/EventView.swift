//
//  EventView.swift
//  OceanPlasticsDemo
//
//  Created by Brendan Chen on 2024.03.18.
//

import SwiftUI
import SwiftData
import MapKit

struct EventView: View {
    var event: Event
    
    @Namespace var mapScope
    
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
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Button(action: {
                            UIApplication.shared.open(event.externalSignupLink)
                        }) {
                            HStack {
                                Spacer()
                                
                                Image(systemName: "arrow.up.right")
                                
                                if let host = event.externalSignupLink.host() {
                                    Text("Sign up on \(host)")
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
                                // TODO: add to calendar logic
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
                            .disabled(true)
                        }
                    }
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading) {
                        Text("About this event")
                            .font(.headline)
                        
                        Text(event.about)
                    }
                    
                    if let lat = event.latitude, let long = event.longitude {
                        Map(initialPosition: .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), latitudinalMeters: 10000, longitudinalMeters: 10000))) {
                            Marker(event.name, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long))
                        }
                        .frame(height: 300)
                        .clipShape(RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/))
                    }
                }
                .padding()
                
                // MARK: - Map
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Nonprofit.self, configurations: config)
    
    // Create an event on April 14th, 2024 at 9:00 AM PST
    let dockweiler = Event(name: "Dockweiler Beach Cleanup", imageAssetName: "dockweiler", date: Date(timeIntervalSince1970: TimeInterval(1713110400)), externalSignupLink: URL(string: "https://surfrider.com")!, bookmarked: false, about: "Join us at one of the largest annual beach cleanups in Southern California! This event is located at Dockweiler Beach, which covers over 3.7 miles and 288 acres of beach, and is situated right next to Los Angeles International Airport. Food and amenities will be provided!", latitude: 33.938803, longitude: -118.440685)
    
    return EventView(event: dockweiler)
}

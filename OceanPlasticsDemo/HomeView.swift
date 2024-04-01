//
//  ContentView.swift
//  OceanPlasticsDemo
//
//  Created by Brendan Chen on 2024.03.18.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query var nonprofits: [Nonprofit]
    @Query var events: [Event]
    
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Following")) {
                    ForEach(nonprofits) {nonprofit in
                        NavigationLink {
                            NonprofitView()
                        } label: {
                            Text(nonprofit.name)
                        }
                    }
                }
                
                Section(header: Text("Upcoming events")) {
                    ForEach(events) { event in
                        // Hack to hide the disclosure indicator displayed by NavigationLink by default
                        ZStack {
                            NavigationLink {
                                EventView()
                            } label: {
                                EmptyView()
                            }
                            .opacity(0.0)
                            CardView(caption: event.nonprofit?.name ?? "", title: event.name, description: event.date.formatted()) {
                                Image(event.imageAssetName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipped()
                            }
                        }
                        .listRowInsets(EdgeInsets())
                    }
                    .listRowSeparator(.hidden)

                    
                    events.count == 0 ? Text("No upcoming events to display.") : nil
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $searchText, prompt: "Search for nonprofits and events...")
    }
}

#Preview {
    HomeView()
        .modelContainer(PlaceholderDataController.previewContainer)
}

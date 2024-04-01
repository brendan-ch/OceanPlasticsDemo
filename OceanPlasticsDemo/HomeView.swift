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
        .modelContainer(PreviewDataController.previewContainer)
}

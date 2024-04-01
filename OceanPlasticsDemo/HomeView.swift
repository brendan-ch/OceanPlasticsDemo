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
    
    var body: some View {
        Text("Home View")
    }
}

#Preview {
    HomeView()
        .modelContainer(PreviewDataController.previewContainer)
}

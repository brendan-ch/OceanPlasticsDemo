//
//  NonprofitView.swift
//  OceanPlasticsDemo
//
//  Created by Brendan Chen on 2024.03.18.
//

import Foundation
import SwiftUI
import SwiftData

struct NonprofitView: View {
    @Environment(\.modelContext) var modelContext
    
    let nonprofit: Nonprofit
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    if let imageName = nonprofit.imageAssetName {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 240)
                    }
                }
                
                Text(nonprofit.name)
            }
        }
        .toolbarBackground(.hidden)
        .ignoresSafeArea()
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Nonprofit.self, configurations: config)
    
    let nonprofit = Nonprofit(name: "Test Nonprofit", following: true, about: "About this nonprofits", externalResources: [], mailingAddress: "1 University Drive, Orange, CA", imageAssetName: "surfrider")
    
    return NonprofitView(nonprofit: nonprofit)
        .modelContainer(container)
}

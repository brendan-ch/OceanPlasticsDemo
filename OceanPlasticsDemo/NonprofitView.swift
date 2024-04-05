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
            VStack(alignment: .leading) {
                if let imageName = nonprofit.imageAssetName {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 240)
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    // MARK: - Title
                    Text(nonprofit.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Button(action: {
                        nonprofit.following.toggle()
                    }) {
                        HStack {
                            Spacer()
                            
                            if !nonprofit.following {
                                Image(systemName: "plus")
                                Text("Follow")
                                    .fontWeight(.medium)
                            } else {
                                Image(systemName: "multiply")
                                Text("Unfollow")
                                    .fontWeight(.medium)
                            }
                            
                            Spacer()
                        }
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    
                    Text(nonprofit.about)
                    
                    // MARK: - Contact info
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Mailing address")
                            .font(.headline)
                        Text(nonprofit.mailingAddress)
                    }
                    
                    VStack(alignment: .leading) {
                        Button(action: {
                            UIPasteboard.general.string = nonprofit.mailingAddress
                        }) {
                            HStack {
                                Image(systemName: "doc.on.doc.fill")
                                Text("Copy mailing address")
                            }
                        }
                        .buttonStyle(.bordered)
                        
                        ForEach(nonprofit.externalResources, id: \.link) { externalResource in
                            Button(action: {
                                UIApplication.shared.open(externalResource.link)
                            }) {
                                HStack {
                                    Image(systemName: externalResource.systemImageName)
                                    Text(externalResource.name)
                                }
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                }
                .padding()
            }
        }
        .toolbarBackground(.hidden)
        .ignoresSafeArea()
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Nonprofit.self, configurations: config)
    
    let externalResources: [ExternalResource] = [
        ExternalResource(name: "Website", systemImageName: "arrow.up.right", link: URL(string: "https://surfrider.com")!)
    ]
    
    let nonprofit = Nonprofit(name: "Test Nonprofit", following: true, about: "The Surfrider Foundation USA is a U.S. 501 grassroots non-profit environmental organization that works to protect and preserve the world's oceans, waves and beaches. It focuses on water quality, beach access, beach and surf spot preservation, and sustaining marine and coastal ecosystems. (Wikipedia)", externalResources: externalResources, mailingAddress: "1 University Drive, Orange, CA", imageAssetName: "surfrider")
    
    return NonprofitView(nonprofit: nonprofit)
        .modelContainer(container)
}

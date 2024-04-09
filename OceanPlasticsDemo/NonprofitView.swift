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
    @Query var events: [Event]
    
    @State private var mailingAddressCopied = false
    
    let nonprofit: Nonprofit
    
    init(nonprofit: Nonprofit) {
        self.nonprofit = nonprofit
        let id = nonprofit.persistentModelID
        
        // See https://stackoverflow.com/questions/77039981/swiftdata-query-with-predicate-on-relationship-model
        _events = Query(filter: #Predicate<Event> { event in
            event.nonprofit?.persistentModelID == id
        }, sort: \Event.date)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // MARK: - Image and title
                if let imageName = nonprofit.imageAssetName {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 240)
                }
                
                VStack(alignment: .leading, spacing: 16) {
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
                    
                    // MARK: - About
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
                            
                            if !mailingAddressCopied {
                                withAnimation {
                                    mailingAddressCopied = true
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    withAnimation {
                                        mailingAddressCopied = false
                                    }
                                }
                            }
                        }) {
                            HStack {
                                if mailingAddressCopied {
                                    Image(systemName: "checkmark")
                                    Text("Copied!")
                                } else {
                                    Image(systemName: "doc.on.doc.fill")
                                    Text("Copy mailing address")
                                }
                            }
                        }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.capsule)
                        
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
                            .buttonBorderShape(.capsule)
                        }
                    }
                }
                .padding()
                
                // MARK: - Upcoming Events
                ForEach(events) { event in
                    // Hack to hide the disclosure indicator displayed by NavigationLink by default
                    ZStack {
                        NavigationLink {
                            EventView()
                        } label: {
                            CardView(caption: event.nonprofit?.name ?? "", title: event.name, description: event.date.formatted()) {
                                Image(event.imageAssetName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 4.0))
                                    .clipped()
                            }
                        }
                        .tint(.primary)
                        
                    }
                    .listRowInsets(EdgeInsets())
                }
                .listRowSeparator(.hidden)
            }
        }
        .ignoresSafeArea(edges: .top)
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
        .modelContainer(PlaceholderDataController.previewContainer)
}

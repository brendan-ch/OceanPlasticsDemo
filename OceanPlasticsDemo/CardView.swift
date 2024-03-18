//
//  CardView.swift
//  OceanPlasticsDemo
//
//  Created by Brendan Chen on 2024.03.18.
//

import Foundation
import SwiftUI

struct CardView<Content: View>: View {
    let imageContent: Content
    let caption: String
    let title: String
    let description: String

    init(caption: String, title: String, description: String, @ViewBuilder content: () -> Content) {
        self.imageContent = content()
        self.caption = caption
        self.title = title
        self.description = description
    }

    var body: some View {
        VStack {
            imageContent
            Text(caption)
            Text(title)
            Text(description)
        }
    }
}

#Preview {
    CardView(caption: "Surfrider Foundation", title: "Dockweiler Beach Cleanup", description: "April 14th, 2024") {
        Image("dockweiler")
            .resizable()
    }
}


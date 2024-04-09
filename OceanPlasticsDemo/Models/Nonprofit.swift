//
//  Nonprofit.swift
//  OceanPlasticsDemo
//
//  Created by Brendan Chen on 2024.03.18.
//

import Foundation
import SwiftData
import SwiftUI

/// Represents an outside link to some external source,
/// such as a nonprofit's website, social media page, or email.
struct ExternalResource: Codable {
    /// Name of the external link to display to the user.
    var name: String
    
    /// Icon image to display next to the name.
    var systemImageName: String
    
    /// Link to the external source.
    var link: URL
}

@Model
class Nonprofit {
    /// All events related to the nonprofit.
    @Relationship(deleteRule: .cascade, inverse: \Event.nonprofit)
    var events = [Event]()
    
    /// Name of the nonprofit organization.
    var name: String
    
    /// Indicates whether the user is following the nonprofit.
    var following: Bool
    
    /// Short description of the nonprofit's mission and values.
    var about: String
    
    /// Array of external resources belonging to the nonprofit, each of which
    /// takes the user outside the app.
    /// Examples include the nonprofit's website, social media pages, etc.
    var externalResources: [ExternalResource]
    
    /// The nonprofit's mailing address.
    var mailingAddress: String
    
    /// A preview image to display with the nonprofit, included in Assets.
    var imageAssetName: String?
    
    init(events: [Event] = [Event](), name: String, following: Bool, about: String, externalResources: [ExternalResource], mailingAddress: String) {
        self.events = events
        self.name = name
        self.following = following
        self.about = about
        self.externalResources = externalResources
        self.mailingAddress = mailingAddress
    }
    
    init(events: [Event] = [Event](), name: String, following: Bool, about: String, externalResources: [ExternalResource], mailingAddress: String, imageAssetName: String) {        
        self.events = events
        self.name = name
        self.following = following
        self.about = about
        self.externalResources = externalResources
        self.mailingAddress = mailingAddress
        self.imageAssetName = imageAssetName
    }
}

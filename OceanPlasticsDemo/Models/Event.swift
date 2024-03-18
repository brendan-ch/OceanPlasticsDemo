//
//  Event.swift
//  OceanPlasticsDemo
//
//  Created by Brendan Chen on 2024.03.18.
//

import Foundation
import SwiftData
import MapKit

@Model
final class Event {
    /// Name of the event.
    var name: String
    
    /// Name of the local image asset to use for the event.
    var imageAssetName: String
    
    /// The nonprofit that the event belongs to.
    var nonprofit: Nonprofit?
    
    /// The date of the event.
    var date: Date
    
    /// External link to the event's sign-up page.
    var externalSignupLink: URL
    
    /// Whether the event is bookmarked by the user.
    var bookmarked: Bool
    
    /// Short description of the event.
    var about: String
    
    /// Latitude of the event's location.
    var latitude: CLLocationDegrees?
    
    /// Longitude of the event's location.
    var longitude: CLLocationDegrees?
    
    init(name: String, imageAssetName: String, date: Date, externalSignupLink: URL, bookmarked: Bool, about: String, latitude: CLLocationDegrees?, longitude: CLLocationDegrees?) {
        self.name = name
        self.imageAssetName = imageAssetName
        self.date = date
        self.externalSignupLink = externalSignupLink
        self.bookmarked = bookmarked
        self.about = about
        
        self.latitude = latitude
        self.longitude = longitude
    }
}

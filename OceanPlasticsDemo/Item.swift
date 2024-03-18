//
//  Item.swift
//  OceanPlasticsDemo
//
//  Created by Brendan Chen on 2024.03.18.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

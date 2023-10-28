//
//  RestaurantModel.swift
//  resto
//
//  Created by Turker Nessa Kucuk on 10/27/23.
//

import Foundation
import SwiftData

@Model
final class RestaurantModel {
    var name: String
    var city: String
    
    init() {
        self.name = "New Restaurant"
        self.city = "Unknown City"
    }
}

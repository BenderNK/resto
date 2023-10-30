//
//  RestaurantModel.swift
//  resto
//
//  Created by Turker Nessa Kucuk on 10/28/23.
//

import Foundation
import SwiftData

@Model
class RestaurantModel {
    /// name of this restaurant
    var name: String
    
    /// address of the restaurant
    var address: String
    
    /// the type of cuisine for this restaurant
    var cuisine: Cuisine
    
    /// user's preferred sort order
    var sortOrder: Int
    
    /// overall rating this user gave to this restaurant
    var starRating: StarRating
    
    init() {
        self.name = "New Restaurant"
        self.address = "current city"
        self.cuisine = .other
        self.sortOrder = -1
        self.starRating = .three
    }
    
    init(name: String, address: String, cuisine: Cuisine, sortOrder: Int, starRating: StarRating) {
        self.name = name
        self.address = address
        self.cuisine = cuisine
        self.sortOrder = sortOrder
        self.starRating = starRating
    }
}

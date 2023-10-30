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
    
    /// street address of the restaurant
    var streetAddress: String
    
    /// street address of the restaurant
    var streetAddress2ndLine: String
    
    /// city of this restaurant
    var city: String
    
    /// state of this restaurant
    var stateOrProvince: String
    
    /// zipcode or postal code of this restaurant
    var postalCode: String
    
    /// the type of cuisine for this restaurant
    var cuisine: Cuisine
    
    /// user's preferred sort order
    var sortOrder: Int
    
    /// overall rating this user gave to this restaurant
    var starRating: StarRating
    
    /// date when this record was created
    let creationDate: Date
    
    init() {
        self.name = "New Restaurant"
        self.streetAddress = "123 Main Street"
        self.streetAddress2ndLine = ""
        self.city = "City"
        self.stateOrProvince = ""
        self.postalCode = ""
        self.cuisine = .other
        self.sortOrder = -1
        self.starRating = .three
        self.creationDate = Date()
    }
    
    init(name: String, streetAddress: String, city: String, stateOrProvince: String,
         postalCode: String, streetAddress2ndLine: String, cuisine: Cuisine, sortOrder: Int, starRating: StarRating) {
        self.name = name
        self.streetAddress = streetAddress
        self.streetAddress2ndLine = streetAddress2ndLine
        self.city = city
        self.stateOrProvince = stateOrProvince
        self.postalCode = postalCode
        
        self.cuisine = cuisine
        self.sortOrder = sortOrder
        self.starRating = starRating
        self.creationDate = Date()
    }
}

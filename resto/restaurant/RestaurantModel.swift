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
    
    /// do not use this value - only added for CoreData semantics
    var _cuisineRawValue: String
    
    /// user's preferred sort order
    var sortOrder: Int
    
    /// do not use this value - only added for CoreData semantics
    var _starRatingRawValue: Int
    
    /// date when this record was created
    let creationDate: Date
    
    init() {
        self.name = "New Restaurant"
        self.streetAddress = "123 Main Street"
        self.streetAddress2ndLine = ""
        self.city = "City"
        self.stateOrProvince = ""
        self.postalCode = ""
        self._cuisineRawValue = Cuisine.other.rawValue
        self.sortOrder = -1
        self._starRatingRawValue = StarRating.three.rawValue
        self.creationDate = Date()
    }
    
    init(name: String, streetAddress: String, city: String, stateOrProvince: String,
         postalCode: String, streetAddress2ndLine: String, cuisine: String,
         sortOrder: Int, starRating: Int) {
        self.name = name
        self.streetAddress = streetAddress
        self.streetAddress2ndLine = streetAddress2ndLine
        self.city = city
        self.stateOrProvince = stateOrProvince
        self.postalCode = postalCode
        
        self._cuisineRawValue = cuisine
        self.sortOrder = sortOrder
        self._starRatingRawValue = starRating
        self.creationDate = Date()
    }
}

extension RestaurantModel {
    /// the type of cuisine for this restaurant
    var cuisine: Cuisine {
        get {
            return Cuisine(rawValue: self._cuisineRawValue)!
        }
        
        set {
            self._cuisineRawValue = newValue.rawValue
        }
    }
    
    var starRating: StarRating {
        get {
            return StarRating(rawValue: self._starRatingRawValue)!
        }
        
        set {
            self._starRatingRawValue = newValue.rawValue
        }
    }
}

//
//  DishObservation.swift
//  resto
//
//  Created by Turker Nessa Kucuk on 10/30/23.
//

import Foundation
import SwiftData

@Model
class DishObservation: HasName {
    /// name of the dish
    var name: String
    
    /// comments regarding this dish
    var remarks: String
    
    /// raw price of this dish at the time of the observation
    var _priceRawValue: String
    
    /// time of the observation
    var observationDate: Date
    
    /// raw rating of this observation
    var _ratingRawValue: Int
    
    init(name: String, remarks: String, price: String, rating: Int, observationDate: Date) {
        self.name = name
        self.remarks = remarks
        self._priceRawValue = price
        self.observationDate = observationDate
        self._ratingRawValue = rating
    }
}

extension DishObservation {
    
    /// price of this dish at the time of the observation
    var price: Decimal {
        get {
            return Decimal(string: self._priceRawValue, locale: Locale(identifier: "en_US_POSIX")) ?? .zero
        }
        set {
            var inOutNewPrice = newValue
            self._priceRawValue = NSDecimalString(&inOutNewPrice, Locale(identifier: "en_US_POSIX"))
        }
    }
    
    /// the rating of this observation
    var dishRating: DishRating {
        get {
            return DishRating(rawValue: self._ratingRawValue)!
        }
        
        set {
            self._ratingRawValue = newValue.rawValue
        }
    }
}

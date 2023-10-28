//
//  DishObservation.swift
//  resto
//
//  Created by Turker Nessa Kucuk on 10/27/23.
//

import Foundation
import SwiftData

@Model
final class DishObservation {
    let parent: RestaurantDetailModel
    var name: String
    var price: Decimal
    var date: Date
    var remarks: String
    var rating: UInt8
    
    init(parent: RestaurantDetailModel) {
        self.parent = parent
        self.name = ""
        self.price = .zero
        self.date = Date(timeIntervalSinceReferenceDate: 0)
        self.remarks = ""
        self.rating = 0
    }
}

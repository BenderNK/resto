//
//  RestaurantDetailModel.swift
//  resto
//
//  Created by Turker Nessa Kucuk on 10/27/23.
//

import Foundation
import SwiftData

@Model
final class RestaurantDetailModel {
    let parent: RestaurantModel
    var restaurantType: RestaurantType
    var address: String
    var observations: [DishObservation]
    
    init(parent: RestaurantModel) {
        self.parent = parent
        self.restaurantType = .Other
        self.address = ""
        self.observations = []
    }
}

//
//  RestaurantType.swift
//  resto
//
//  Created by Turker Nessa Kucuk on 10/27/23.
//

import Foundation

enum RestaurantType: String, CaseIterable, Identifiable, Codable, Hashable {
    case American
    case Japanese
    case Korean
    case Italian
    case Mexican
    case Other
    case Sushi
    case Mediterrenean
    case French
    case German
    case South_American
    
    var id: Self { self }
}

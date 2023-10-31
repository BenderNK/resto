//
//  Cuisine.swift
//  resto
//
//  Created by Turker Nessa Kucuk on 10/28/23.
//

import Foundation

enum Cuisine: String, CaseIterable, Identifiable, Codable, Hashable, HasName, Comparable {
    case american
    case japanese
    case korean
    case italian
    case mexican
    case other
    case sushi
    case mediterrenean
    case french
    case german
    case south_american
    case subshop
    
    var id: Self { self }
    
    var name: String {
        self.rawValue.capitalized
    }
    
    static func < (lhs: Cuisine, rhs: Cuisine) -> Bool {
        return lhs.name < rhs.name
    }
}

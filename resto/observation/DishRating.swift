//
//  DishRating.swift
//  resto
//
//  Created by Turker Nessa Kucuk on 10/28/23.
//

import Foundation

enum DishRating: Int, CaseIterable, Identifiable, Codable, Hashable, Comparable {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
    
    var id: Self { self }
    
    static func < (lhs: DishRating, rhs: DishRating) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

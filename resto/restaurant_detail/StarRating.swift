//
//  StarRating.swift
//  resto
//
//  Created by Turker Nessa Kucuk on 10/28/23.
//

import Foundation

enum StarRating: Int, CaseIterable, Identifiable, Codable, Hashable, Comparable {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    
    var id: Self { self }
    
    static func < (lhs: StarRating, rhs: StarRating) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

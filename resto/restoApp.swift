//
//  restoApp.swift
//  resto
//
//  Created by Turker Nessa Kucuk on 10/28/23.
//

import SwiftUI
import SwiftData

@main
struct restoApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: RestaurantModel.self)
    }
}

//
//  restoApp.swift
//  resto
//
//  Created by Turker Nessa Kucuk on 10/27/23.
//

import SwiftUI
import SwiftData

@main
struct restoApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            RestaurantModel.self, RestaurantDetailModel.self, DishObservation.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            RestaurantsView()
        }
        .modelContainer(sharedModelContainer)
    }
}

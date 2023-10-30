//
//  ContentView.swift
//  resto
//
//  Created by Turker Nessa Kucuk on 10/28/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @State private var sortOrder = SortDescriptor(\RestaurantModel.creationDate, order: .reverse)
    @State private var columnVisibility = NavigationSplitViewVisibility.doubleColumn
    @State private var path = [RestaurantModel]()

    var body: some View {
        NavigationSplitView(sidebar: {
            RestaurantSorterView(with: self.sortOrder)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: addRestaurant) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                    ToolbarItem {
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort", selection: $sortOrder) {
                                Text("Name")
                                    .tag(SortDescriptor(\RestaurantModel.name))
                                Text("City")
                                    .tag(SortDescriptor(\RestaurantModel.city))
                                Text("Cuisine")
                                    .tag(SortDescriptor(\RestaurantModel._cuisineStringValue))
                                Text("Rating")
                                    .tag(SortDescriptor(\RestaurantModel._starRatingIntValue, order: .reverse))
                                Text("Creation Date")
                                    .tag(SortDescriptor(\RestaurantModel.creationDate, order: .reverse))
                            }.pickerStyle(.inline)
                        }
                    }
                }
                .navigationTitle("Restaurants")
                .navigationBarTitleDisplayMode(.automatic)
                .navigationDestination(for: RestaurantModel.self, destination: { clickedRestaurant in
                    RestaurantDetailView(restaurant: clickedRestaurant)
                })
        }, detail: {
            
        })
    }

    private func addRestaurant() {
        withAnimation {
            let newItem = RestaurantModel()
            modelContext.insert(newItem)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: RestaurantModel.self, inMemory: true)
}

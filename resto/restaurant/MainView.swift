//
//  MainView.swift
//  resto
//
//  Created by Turker Nessa Kucuk on 10/28/23.
//

import SwiftUI
import SwiftData

struct MainView: View {
    
    @Environment(\.modelContext) private var modelContext
    @State private var sortOrder = SortDescriptor(\RestaurantModel.creationDate, order: .reverse)
    @State private var columnVisibility = NavigationSplitViewVisibility.doubleColumn
    @State private var path = [RestaurantModel]()
    @State private var searchText = ""

    var body: some View {
        NavigationSplitView(sidebar: {
            RestaurantSorterView(with: self.sortOrder, searchString: searchText)
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
                                    .tag(SortDescriptor(\RestaurantModel._cuisineRawValue))
                                Text("Rating")
                                    .tag(SortDescriptor(\RestaurantModel._starRatingRawValue, order: .reverse))
                                Text("Creation Date")
                                    .tag(SortDescriptor(\RestaurantModel.creationDate, order: .reverse))
                            }.pickerStyle(.inline)
                        }
                    }
                }
                .searchable(text: $searchText)
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
    MainView()
        .modelContainer(for: RestaurantModel.self, inMemory: true)
}

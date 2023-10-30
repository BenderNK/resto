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
    @Query private var restaurants: [RestaurantModel]
    @State private var columnVisibility = NavigationSplitViewVisibility.doubleColumn
    @State private var path = [RestaurantModel]()

    var body: some View {
        NavigationSplitView(sidebar: {
            List {
                ForEach(restaurants) { eachRestaurant in
                    NavigationLink(value: eachRestaurant) {
                        VStack(alignment: .leading, spacing: 4, content: {
                            Text(eachRestaurant.name).font(.headline)
                            Text(eachRestaurant.address).font(.subheadline)
                            Text(eachRestaurant.cuisine.name).font(.footnote).foregroundStyle(.gray)
                        })
                    }
                }
                .onDelete(perform: deleteRestaurants)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addRestaurant) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                ToolbarItem {
                    EditButton()
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

    private func deleteRestaurants(indexSet: IndexSet) {
        withAnimation {
            for index in indexSet {
                let restaurantToDelete = restaurants[index]
                modelContext.delete(restaurantToDelete)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: RestaurantModel.self, inMemory: true)
}

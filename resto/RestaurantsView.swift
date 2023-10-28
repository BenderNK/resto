//
//  RestaurantsView.swift
//  resto
//
//  Created by Turker Nessa Kucuk on 10/27/23.
//

import SwiftUI
import SwiftData

struct RestaurantsView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var restaurants: [RestaurantModel]
    @State private var columnVisibility = NavigationSplitViewVisibility.all

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility,
            sidebar: {
            List {
                ForEach(restaurants) { eachRestaurant in
                    NavigationLink {
                        let detailView = RestaurantDetailView(parent: eachRestaurant)
                        detailView
                    } label: {
                        Text(eachRestaurant.name)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }, detail: {
            
        })
    }

    private func addItem() {
        withAnimation {
            let newItem = RestaurantModel()
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(restaurants[index])
            }
        }
    }
}

#Preview {
    RestaurantsView()
        .modelContainer(for: RestaurantModel.self, inMemory: true)
}

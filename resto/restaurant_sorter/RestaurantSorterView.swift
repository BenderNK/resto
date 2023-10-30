//
//  RestaurantSorterView.swift
//  resto
//
//  Created by Turker Nessa Kucuk on 10/29/23.
//

import SwiftData
import SwiftUI

struct RestaurantSorterView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \RestaurantModel.creationDate, order: .reverse) private var restaurants: [RestaurantModel]
    
    init(with sort: SortDescriptor<RestaurantModel>) {
        self._restaurants = Query(sort: [sort])
    }
    
    var body: some View {
        List {
            ForEach(restaurants) { eachRestaurant in
                NavigationLink(value: eachRestaurant) {
                    VStack(alignment: .leading, spacing: 4, content: {
                        Text(eachRestaurant.name).font(.headline)
                        Text(eachRestaurant.city).font(.subheadline)
                        Text(eachRestaurant.cuisine.name).font(.footnote).foregroundStyle(.gray)
                    })
                }
            }
            .onDelete(perform: deleteRestaurants)
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
    RestaurantSorterView(with: SortDescriptor(\RestaurantModel.creationDate, order: .reverse))
}

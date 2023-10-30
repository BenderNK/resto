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
    
    init(with sort: SortDescriptor<RestaurantModel>, searchString: String = "") {
        let filterPredicate: Predicate<RestaurantModel> = #Predicate { eachRestaurant in
            if searchString.isEmpty {
                return true
            } else {
                return (eachRestaurant.name.localizedStandardContains(searchString) ||
                    eachRestaurant._cuisineRawValue.localizedStandardContains(searchString) ||
                    eachRestaurant.streetAddress.localizedStandardContains(searchString) ||
                    eachRestaurant.streetAddress2ndLine.localizedStandardContains(searchString) ||
                    eachRestaurant.city.localizedStandardContains(searchString) ||
                    eachRestaurant.stateOrProvince.localizedStandardContains(searchString) ||
                    eachRestaurant.postalCode.localizedStandardContains(searchString))
            }
        }
        self._restaurants = Query(filter: filterPredicate, sort: [sort])
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

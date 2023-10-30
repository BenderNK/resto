//
//  RestaurantDetailView.swift
//  resto
//
//  Created by Turker Nessa Kucuk on 10/28/23.
//

import SwiftUI
import SwiftData

struct RestaurantDetailView: View {
    @Bindable var restaurant: RestaurantModel
    
    var body: some View {
        Form {
            Section(header: Text("Restaurant info")) {
                TextField("Restaurant Name", text: $restaurant.name)
                    .font(.body)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.words)
                   
                TextField("Address", text: $restaurant.address, axis: .vertical)
                    .font(.body)
                
                Picker("Cuisine", selection: $restaurant.cuisine) {
                    ForEach(Cuisine.allCases) { eachCuisine in
                        Text(eachCuisine.rawValue.capitalized)
                    }
                }
            }
            
            Section(header: Text("Rating")) {
                Picker("Rating", selection: $restaurant.starRating) {
                    ForEach(StarRating.allCases) { eachRating in
                        Text(String(eachRating.rawValue))
                    }
                }.pickerStyle(.segmented)
            }
            /*
            Section(header: Text("Observations")) {
                ForEach($observations) { eachObs in
                    TextField("Dish", text: eachObs.name).font(.body)
                    TextField("Remarks", text: eachObs.remarks).font(.body)
                    //TextField("Price", text: eachObs.price.formatted()).font(.body)
                    //TextField("Rating", text: eachObs.rating.string).font(.body)
                }
                Button("Add Observation", action: {})
            }
            */
        }
        //.navigationTitle("Edit Restaurant")
        .toolbar {
            ToolbarItem {
                Button(action: addRestaurant) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }
    
    private func addRestaurant() {
        withAnimation {
            //let newItem = RestaurantModel()
            //modelContext.insert(newItem)
        }
    }

    private func deleteRestaurants(indexSet: IndexSet) {
        withAnimation {
            //for index in indexSet {
            //    let restaurantToDelete = restaurants[index]
            //    modelContext.delete(restaurantToDelete)
            //}
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: RestaurantModel.self, configurations: config)
        let exampleRestaurant = RestaurantModel(name: "Panka Peruvian",
                                                address: "2837 Freeman Dr\nAnn Arbor, MI 40393",
                                                cuisine: .italian,
                                                sortOrder: 9,
                                                starRating: .three)
        return RestaurantDetailView(restaurant: exampleRestaurant)
    } catch {
        fatalError("model container cannot be created")
    }
}

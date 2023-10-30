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
                
                TextField("Address", text: $restaurant.streetAddress, axis: .vertical)
                    .font(.body)
                
                GeometryReader { metrics in
                    HStack(spacing: 4, content: {
                        TextField("City", text: $restaurant.city)
                            .font(.body)
                            .frame(width: metrics.size.width * 0.50)
                        Divider()
                        TextField("State", text: $restaurant.stateOrProvince)
                            .font(.body)
                            .frame(width: metrics.size.width * 0.20)
                        Divider()
                        TextField("Zipcode", text: $restaurant.postalCode)
                            .font(.body)
                    })
                }
                
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
        }
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
                                                streetAddress: "2837 Freeman Dr",
                                                city: "Ann Arbor",
                                                stateOrProvince: "MI",
                                                postalCode: "30492",
                                                streetAddress2ndLine: "",
                                                cuisine: Cuisine.italian.rawValue,
                                                sortOrder: 9,
                                                starRating: StarRating.three.rawValue)
        return RestaurantDetailView(restaurant: exampleRestaurant)
    } catch {
        fatalError("model container cannot be created")
    }
}

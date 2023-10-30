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
    @State private var newDishName: String = ""
    
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
            
            Section(header: Text("Observations")) {
                TextField("Dish Name", text: $newDishName)
                    .font(.body)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.words)
            
            }
            
        }
        .toolbar {
            ToolbarItem {
                Button(action: addNewObservation) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }
    
    private func addNewObservation() {
        withAnimation {
            guard !newDishName.isEmpty else { return }
            let newDishObservation = DishObservation(name: newDishName,
                                          remarks: "",
                                          price: "0",
                                          rating: 5,
                                          observationDate: Date.now)
            restaurant.observations.append(newDishObservation)
            newDishName = ""
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
        
        let exampleObservation1 = DishObservation(name: "burrito",
                                                  remarks: "I thought that the burrito was too spicy and didn't have sufficient acidity",
                                                  price: "8.95",
                                                  rating: 6,
                                                  observationDate: Date.now)
        
        let exampleObservation2 = DishObservation(name: "turkey sandwich",
                                                  remarks: "Sandwich was well made, was fresh and the bread was baked perfectly",
                                                  price: "7.45",
                                                  rating: 9,
                                                  observationDate: Date.now)
        
        let exampleRestaurant = RestaurantModel(name: "Panka Peruvian",
                                                streetAddress: "2837 Freeman Dr",
                                                city: "Ann Arbor",
                                                stateOrProvince: "MI",
                                                postalCode: "30492",
                                                streetAddress2ndLine: "",
                                                cuisine: Cuisine.italian.rawValue,
                                                sortOrder: 9,
                                                starRating: StarRating.three.rawValue,
                                                observations: [exampleObservation1, exampleObservation2])
        return RestaurantDetailView(restaurant: exampleRestaurant)
    } catch {
        fatalError("model container cannot be created")
    }
}

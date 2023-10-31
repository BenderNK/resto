//
//  RestaurantDetailView.swift
//  resto
//
//  Created by Turker Nessa Kucuk on 10/28/23.
//

import SwiftUI
import SwiftData

struct RestaurantDetailView: View {
    @Environment(\.modelContext) private var modelContext
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
            
            Button(action: addNewObservation, label: {
                Text("Add new observation")
            })
            
            
            Section(header: Text("Observations")) {
                List {
                    ForEach(restaurant.observations) { eachObservation in
                        NavigationLink(value: eachObservation, label: {
                            VStack(alignment: .leading, spacing: 4, content: {
                                Text(eachObservation.name).font(.headline)
                                Text(eachObservation.remarks).font(.subheadline)
                                Text(String(eachObservation.dishRating.rawValue)).font(.footnote).foregroundStyle(.gray)
                            })
                        })
                    }
                    .onDelete(perform: deleteObservation)
                }
            }
        }
        .navigationTitle(restaurant.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: DishObservation.self, destination: { thisDish in
            DishDetailView(dishObservation: thisDish)
        })
        .toolbar {
            ToolbarItem {
                Button(action: addNewObservation, label: {
                    Label("Add Item", systemImage: "plus")
                })
            }
        }
    }
    
    private func addNewObservation() {
        withAnimation {
            let newDishObservation = DishObservation(name: "Dish name",
                                                     remarks: "",
                                                     price: "",
                                                     rating: 5,
                                                     observationDate: Date.now)
            restaurant.observations.append(newDishObservation)
        }
    }

    private func deleteObservation(indexSet: IndexSet) {
        withAnimation {
            //need to perform deep copy before deletion
            //see: https://stackoverflow.com/questions/77120576/how-do-i-delete-child-items-from-list-with-swiftdata
            for index in indexSet {
                let obsToDelete = restaurant.observations[index]
                let objectId = obsToDelete.persistentModelID
                let deepCopy = modelContext.model(for: objectId)
                modelContext.delete(deepCopy)
            }
            
            restaurant.observations.remove(atOffsets: indexSet)
            do {
                try modelContext.save()
            } catch {
                print("Error saving context \(error)")
            }
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

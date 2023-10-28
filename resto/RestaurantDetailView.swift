//
//  RestaurantDetailView.swift
//  resto
//
//  Created by Turker Nessa Kucuk on 10/27/23.
//

import SwiftUI
import SwiftData

struct RestaurantDetailView: View {
    @State private var parentRestaurant: RestaurantModel
    
    init(parent: RestaurantModel) {
        self.parentRestaurant = parent
    }
    
    
    @State private var restaurantType: RestaurantType = .Other
    @State private var restaurantAddress: String = ""
    @State private var observations: [DishObservation] = []
    
    var body: some View {
        Form {
            Section(header: Text("Restaurant info")) {
                TextField("Restaurant Name", text: $parentRestaurant.name)
                    .font(.body)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.words)
                    
                Picker("Cuisine", selection: $restaurantType) {
                    ForEach(RestaurantType.allCases) { eachRestaurantType in
                        Text(eachRestaurantType.rawValue.capitalized)
                    }
                }
                TextField("Address", text: $restaurantAddress).font(.body)
            }
            Section(header: Text("Observations")) {
                ForEach($observations) { eachObs in
                    TextField("Dish", text: eachObs.name).font(.body)
                    TextField("Remarks", text: eachObs.remarks).font(.body)
                    //TextField("Price", text: eachObs.price.formatted()).font(.body)
                    //TextField("Rating", text: eachObs.rating.string).font(.body)
                }
                Button("Add Observation", action: {})
            }
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
    }
    
    private func addItem() {
        withAnimation {
            let detail = RestaurantDetailModel(parent: parentRestaurant)
            let newItem = DishObservation(parent: detail)
            observations.append(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                observations.remove(at: index)
            }
        }
    }
}

#Preview {
    RestaurantDetailView(parent: RestaurantModel())
        .modelContainer(for: RestaurantDetailModel.self, inMemory: true)
}

//
//  DishDetailView.swift
//  resto
//
//  Created by Turker Nessa Kucuk on 10/28/23.
//

import SwiftUI
import SwiftData

struct DishDetailView: View {
    
    @Bindable var dishObservation: DishObservation
    @State private var newDishName: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Observation")) {
                TextField("Dish Name", text: $dishObservation.name)
                    .font(.body)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.words)
                
                TextField("Remarks", text: $dishObservation.remarks, axis: .vertical)
                    .font(.body)
                
                TextField("Price",
                          value: $dishObservation.price,
                          format: .currency(code: "USD"))
                
                DatePicker("Date", selection: $dishObservation.observationDate)
                    .datePickerStyle(.compact)
                    .frame(maxHeight: 400)
                    
            }
            
            Section(header: Text("Rating")) {
                Picker("Rating", selection: $dishObservation.dishRating) {
                    ForEach(DishRating.allCases) { eachRating in
                        Text(String(eachRating.rawValue))
                    }
                }
            }
        }
        .navigationTitle(dishObservation.name)
        .navigationBarTitleDisplayMode(.inline)
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
        let container = try ModelContainer(for: DishObservation.self, configurations: config)
        
        let exampleObservation1 = DishObservation(name: "burrito",
                                                  remarks: "I thought that the burrito was too spicy and didn't have sufficient acidity",
                                                  price: "8.95",
                                                  rating: 6,
                                                  observationDate: Date.now)
        return DishDetailView(dishObservation: exampleObservation1)
    } catch {
        fatalError("model container cannot be created")
    }
}

//
//  RecipeView.swift
//  VirtualPantry
//
//  Created by James Dansie on 11/28/22.
//

import SwiftUI

struct RecipeView: View {
    var selectedRecipe: Recipe
    @Binding var pantryItems: [Item]
    @State var showUseRecipe: Bool = false;
    
    var body: some View {
        
        Text(selectedRecipe.name)
            .font(.headline)
            .padding()
        
        Text("Description: " + selectedRecipe.description)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        
        Text("Ingredients: ")
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        
        VStack {
            ForEach(selectedRecipe.ingredients, id: \.name) { ingredient in
                HStack {
                    if(ingredient.unit != "") {
                        Text(ingredient.name + " (" + ingredient.unit + ") ")
                    } else {
                        Text(ingredient.name)
                    }
                    
                    Text(ingredient.quantity.codingKey.stringValue).frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.horizontal)
            }
        }
        
        Text("Instructions: ")
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        
        VStack {
            ForEach(selectedRecipe.instructions, id: \.self) { instruction in
                HStack {
                    Text(instruction).frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal)
            }
        }
        
        Button(action: {
            showUseRecipe = true
        }) {
            Text("USE INGREDIENTS")
        }
        .font(.headline)
        .foregroundColor(.white)
        .padding()
        .frame(width: 220, height: 60)
        .background(Color.green)
        .cornerRadius(15.0)
        .popover(isPresented: $showUseRecipe) {
            
            Text("Are you sure you want to use this recipe? All ingredients will be removed from your pantry.")
                .font(.headline)
                .padding()
            
            Button(action: {
                for item in selectedRecipe.ingredients {
                    var i = 0
                    while i < pantryItems.count {
                        if pantryItems[i].name == item.name {
                            print("Quant before: ", pantryItems[i].quantity)
                            pantryItems[i].quantity = pantryItems[i].quantity - item.quantity
                            print("Quant after: ", pantryItems[i].quantity)
                            if pantryItems[i].quantity > 0 {
                                pantryItems.append(pantryItems[i])
                            }
                            pantryItems.remove(at: i)
                        }
                        i += 1
                    }
                }
                showUseRecipe = false
            }) {
                Text("COMPLETE")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.green)
                    .cornerRadius(15.0)
            }
            
            Button(action: {showUseRecipe = false}) {
                Text("CANCEL")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.green)
                    .cornerRadius(15.0)
            }
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        let ingredient1: Item = Item(name: "beans", quantity: 2, unit: "oz")
        let ingredient2: Item = Item(name: "beef", quantity: 1, unit: "lbs")
        let recipe1: Recipe = Recipe(name: "Beef Tacos", description: "Best tacos out there", instructions: ["Brown the meat.", "Add beans"], ingredients: [ingredient1, ingredient2])
        let pantryItem1: Item = Item(name: "beans", quantity: 2, unit: "oz")
        let pantryItem2: Item = Item(name: "apple", quantity: 1, unit: "")
        let pantryItems: [Item] = [pantryItem1, pantryItem2]
        RecipeView(selectedRecipe: recipe1, pantryItems: .constant(pantryItems))
    }
}

//
//  Recipes.swift
//  VirtualPantry
//
//  Created by James Dansie on 11/7/22.
//

import SwiftUI

struct Recipes: View {
    @Binding var allRecipes: [Recipe]
    @Binding var pantryItems: [Item]
    @State var showRecipe: Bool = false
    @State var selectedRecipe: Recipe
    
    var recipes: [Recipe] {
        var tempRecipes: [Recipe] = []
        for recipe in allRecipes {
            var allIngredientsFound = true
            for ingredient in recipe.ingredients {
                if !pantryItems.contains(where: {$0.name == ingredient.name && $0.quantity >= ingredient.quantity && $0.unit == ingredient.unit}) {
                    allIngredientsFound = false
                }
            }
            if allIngredientsFound {
                tempRecipes.append(recipe)
            }
        }
        return tempRecipes
    }
    
    var body: some View {
        VStack {
            Text("Recipes")
                .padding(.bottom)
            
            if(recipes.count == 0) {
                Text("No recipes to display")
                    .padding(.bottom)
            }
            
            List {
                ForEach(recipes, id: \.name) { recipe in
                    Button(action: {
                        print("selecting recipe: ", recipe.name)
                        selectedRecipe = recipe
                        print("selected recipe: ", selectedRecipe.name)
                        showRecipe = true
                    }) {
                        Text(recipe.name)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .popover(isPresented: $showRecipe) {
                
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
                    showRecipe = false
                    //TODO: DO stuff here
                }) {
                    Text("USE RECIPE")
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.green)
                .cornerRadius(15.0)
                
                Button(action: {showRecipe = false}) {
                    Text("CLOSE")
                }
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

struct Recipes_Previews: PreviewProvider {
    static var previews: some View {
        var ingredient1: Item = Item(name: "beans", quantity: 2, unit: "oz")
        var ingredient2: Item = Item(name: "beef", quantity: 1, unit: "lbs")
        var recipe1: Recipe = Recipe(name: "Beef Tacos", description: "Best tacos out there", instructions: ["Brown the meat.", "Add beans"], ingredients: [ingredient1, ingredient2])
        var recipe2: Recipe = Recipe(name: "Beef Tacos2", description: "Best tacos out there", instructions: ["Brown the meat.", "Add beans"], ingredients: [ingredient1, ingredient2])
        let pantryItem1: Item = Item(name: "beans", quantity: 2, unit: "oz")
        let pantryItem2: Item = Item(name: "apple", quantity: 1, unit: "")
        let pantryItems: [Item] = [pantryItem1, pantryItem2]
        Recipes(allRecipes: .constant([recipe1, recipe2]), pantryItems: .constant(pantryItems), selectedRecipe: recipe1)
    }
}

class Recipe {
    var name: String
    var description: String
    var instructions: [String]
    var ingredients: [Item]
    
    init(name: String, description: String, instructions: [String], ingredients: [Item]) {
        self.name = name
        self.description = description
        self.instructions = instructions
        self.ingredients = ingredients
    }
}

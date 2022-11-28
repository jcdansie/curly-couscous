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
        
        NavigationView {
            VStack {
                Text("Recipes")
                    .padding(.bottom)
                
                if(recipes.count == 0) {
                    Text("No recipes to display")
                        .padding(.bottom)
                }
                
                List {
                    ForEach(recipes, id: \.name) { recipe in
                        NavigationLink(destination: RecipeView(selectedRecipe: recipe, pantryItems: $pantryItems)){
                            Text(recipe.name).frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            }
        }
    }
}



struct Recipes_Previews: PreviewProvider {
    static var previews: some View {
        let ingredient1: Item = Item(name: "beans", quantity: 2, unit: "oz")
        let ingredient2: Item = Item(name: "beef", quantity: 1, unit: "lbs")
        let recipe1: Recipe = Recipe(name: "Beef Tacos", description: "Best tacos out there", instructions: ["Brown the meat.", "Add beans"], ingredients: [ingredient1, ingredient2])
        let recipe2: Recipe = Recipe(name: "Beef Tacos2", description: "Best tacos out there", instructions: ["Brown the meat.", "Add beans"], ingredients: [ingredient1, ingredient2])
        let pantryItem1: Item = Item(name: "beans", quantity: 2, unit: "oz")
        let pantryItem2: Item = Item(name: "apple", quantity: 1, unit: "")
        let pantryItems: [Item] = [pantryItem1, pantryItem2]
        Recipes(allRecipes: .constant([recipe1, recipe2]), pantryItems: .constant(pantryItems))
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

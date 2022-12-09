//
//  ContentView.swift
//  VirtualPantry
//
//  Created by James Dansie on 11/3/22.
//

import SwiftUI

var item1: Item = Item(name: "Beans", quantity: 2, unit: "oz")
var item2: Item = Item(name: "Beef", quantity: 1, unit: "lbs")
var item3: Item = Item(name: "Apple", quantity: 1, unit: "qty")
var item4: Item = Item(name: "Onion", quantity: 1, unit: "qty")
var item5: Item = Item(name: "Milk", quantity: 1, unit: "gal")
var item6: Item = Item(name: "Spaghetti", quantity: 15, unit: "oz")
var item7: Item = Item(name: "Tomato Sauce", quantity: 16, unit: "oz")
var item8: Item = Item(name: "Bell pepper", quantity: 3, unit: "qty")
var item9: Item = Item(name: "Egg", quantity: 12, unit: "qty")
var recipeItem1: Item = Item(name: "Beans", quantity: 2, unit: "oz")
var recipeItem2: Item = Item(name: "Beef", quantity: 1, unit: "lbs")
var recipeItem6: Item = Item(name: "Spaghetti", quantity: 15, unit: "oz")
var recipeItem7: Item = Item(name: "Tomato Sauce", quantity: 16, unit: "oz")
var recipeItem8: Item = Item(name: "Salmon", quantity: 12, unit: "oz")
var recipeItem9: Item = Item(name: "Rice", quantity: 16, unit: "oz")
var recipeItem10: Item = Item(name: "Egg", quantity: 2, unit: "qty")
var recipeItem11: Item = Item(name: "Bell pepper", quantity: 1, unit: "qty")

var recipe1: Recipe = Recipe(name: "Beef Tacos", description: "Best tacos out there", instructions: ["Brown the meat.", "Add beans"], ingredients: [recipeItem1, recipeItem2])
var recipe2: Recipe = Recipe(name: "Spaghetti", description: "Just like your mom made!", instructions: ["Brown the meat.", "Add tomato sauce to meat", "Boil pasta for 8 minutes", "Put meat and sauce over pasta"], ingredients: [recipeItem2, recipeItem6, recipeItem7])
var recipe3: Recipe = Recipe(name: "Pan Seared Salmon", description: "Quick and delicous meal for fish lovers!", instructions: ["Heat olive oil in pan on medium", "Add salmon to pan", "Cook each side for 8 minutes", "Boil water", "Add rice", "Cook for 10 minutes covered"], ingredients: [recipeItem8, recipeItem9])
var recipe4: Recipe = Recipe(name: "Classic Omelette", description: "Perfect start to the day!", instructions: ["Crack eggs in bowl, wisk.", "Heat medium pan on medium", "Dice the peppers and add to eggs", "Pour eggs and peppers onto pan", "Cook five three minutes each side"], ingredients: [recipeItem10, recipeItem11])

struct ContentView : View {
    @State var shoppingItems: [Item] = [item1, item4, item5]
    @State var pantryItems: [Item] = [item2, item3, item6, item7, item8, item9]
    @State var recipes: [Recipe] = [recipe1, recipe2, recipe3, recipe4]
    @State var username: String = "johndoe"
    @State var firstName: String = "John"
    @State var lastName: String = "Doe"
    
    var availableRecipes: [Recipe] {
        var tempRecipes: [Recipe] = []
        for recipe in recipes {
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
    
    @Binding var isLoggedIn:Bool
    
    var body: some View {
        TabView {
            Pantry(pantryItems: $pantryItems)
                .tabItem() {
                    Image(systemName: "refrigerator")
                    Text("Pantry")
                }
            ShoppingList(shoppingItems: $shoppingItems, pantryItems: $pantryItems)
                .tabItem() {
                    Image(systemName: "list.bullet")
                    Text("Shopping List")
                }
            Recipes(allRecipes: $recipes, pantryItems: $pantryItems)
                .tabItem() {
                    Image(systemName: "note.text")
                    Text("Recipes")
                }
            Profile(username: $username, firstName: $firstName, lastName: $lastName, isLoggedIn: $isLoggedIn)
                .tabItem() {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

//PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(isLoggedIn: .constant(true))
    }
}

class Item {
    var name: String
    var quantity: Int
    var unit: String
    
    init(name: String, quantity: Int, unit: String) {
        self.name = name
        self.quantity = quantity
        self.unit = unit
    }
}

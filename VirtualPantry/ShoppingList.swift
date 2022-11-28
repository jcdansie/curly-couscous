//
//  ShoppingList.swift
//  VirtualPantry
//
//  Created by James Dansie on 11/7/22.
//

import SwiftUI

struct ShoppingList: View {
    @Binding var shoppingItems: [Item]
    @Binding var pantryItems: [Item]
    @State var showAddItem: Bool = false;
    @State var showCompleteShopping: Bool = false;
    @State var itemName: String = ""
    @State var itemUnit: String = ""
    @State var itemAmount: String = ""
    
    var body: some View {
        VStack {
            Text("Shopping List")
                .padding(.bottom)
            
            if(shoppingItems.count == 0) {
                Text("No items to display")
                    .padding(.bottom)
            }
            
            List {
                ForEach(shoppingItems, id: \.name) { item in
                    ShoppingItemRow(items: $shoppingItems, item: item)
                        
                }
            }
            
            Button(action: {showAddItem = true}) {
               Text("ADD")
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
            
            if(shoppingItems.count != 0) {
                Button(action: {showCompleteShopping = true}) {
                   Text("ADD TO PANTRY")
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.green)
                .cornerRadius(15.0)
            }
        }
        .popover(isPresented: $showAddItem) {
            
            let units = ["qty", "oz", "gal", "lbs"]
            
            Text("Add Item to Shopping List")
                .font(.headline)
                .padding()
            
            TextField("Item Name", text: $itemName)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding([.leading, .bottom, .trailing], 20)
            
            Picker("Select a unit", selection: $itemUnit) {
                ForEach(units, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.menu)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding([.leading, .bottom, .trailing], 20)
            
            TextField("amount", text: $itemAmount)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding([.leading, .bottom, .trailing], 20)
                .keyboardType(.decimalPad)
            
            Button(action: {
                let newItem = Item(name: itemName, quantity: Int(itemAmount) ?? 0, unit: itemUnit)
                for i in 0..<shoppingItems.count {
                    if shoppingItems[i].name == newItem.name {
                        newItem.quantity = newItem.quantity + shoppingItems[i].quantity
                        shoppingItems.remove(at: i)
                    }
                }
                shoppingItems.append(newItem)
                showAddItem = false
                itemName = ""
                itemAmount = ""
                itemUnit = ""
            }) {
                Text("SAVE")
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
            
            Button(action: {
                showAddItem = false
                itemName = ""
                itemAmount = ""
                itemUnit = ""
            }) {
                Text("CANCEL")
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
        }
        .popover(isPresented: $showCompleteShopping) {
            
            Text("If your current shopping list doesn't reflect your actual purchases, please update your list and then complete shopping.")
                .font(.headline)
                .padding()
            
            Text("Are you sure you want to complete your shopping list? All items will be added to your pantry.")
                .font(.headline)
                .padding()
            
            Button(action: {
                for item in shoppingItems {
                    for i in 0..<pantryItems.count {
                        if pantryItems[i].name == item.name {
                            item.quantity = item.quantity + pantryItems[i].quantity
                            pantryItems.remove(at: i)
                        }
                    }
                    pantryItems.append(item)
                }
                shoppingItems = []
                showCompleteShopping = false
            }) {
                Text("COMPLETE")
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
            
            Button(action: {showCompleteShopping = false}) {
                Text("CANCEL")
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

struct ShoppingList_Previews: PreviewProvider {
    static var previews: some View {
        let shoppingItem1: Item = Item(name: "beans", quantity: 2, unit: "oz")
        let shoppingItem2: Item = Item(name: "apple", quantity: 1, unit: "")
        let shoppingItems: [Item] = [shoppingItem1, shoppingItem2]
        let pantryItems: [Item] = [shoppingItem1, shoppingItem2]
        ShoppingList(shoppingItems: .constant(shoppingItems), pantryItems: .constant(pantryItems))
    }
}

struct ShoppingItemRow: View {
    @State var showEditItem: Bool = false;
    @State var editItemAmount: String = "";
    @Binding var items: [Item]
    var item: Item

    var body: some View {
        HStack {
            if(item.unit != "") {
                Text(item.name + " (" + item.unit + ") ")
            } else {
                Text(item.name)
            }
            
            Button(action: {showEditItem = true}) {
                Text(item.quantity.codingKey.stringValue)
            }.frame(maxWidth: .infinity, alignment: .trailing)
        }
        .popover(isPresented: $showEditItem) {
            
            Text("Update " + item.name + " quantity")
                .font(.headline)
                .padding()
            
            TextField("amount", text: $editItemAmount)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding([.leading, .bottom, .trailing], 20)
                .keyboardType(.decimalPad)
            
            Button(action: {
                item.quantity = Int(editItemAmount) ?? 0
                for i in 0..<items.count {
                    if items[i].name == item.name {
                        items.remove(at: i)
                        items.append(item)
                    }
                }
                showEditItem = false
            }) {
                Text("SAVE")
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
            
            Button(action: {
                for i in 0..<items.count {
                    if items[i].name == item.name {
                        items.remove(at: i)
                        break
                    }
                }
                showEditItem = false
            }) {
                Text("REMOVE")
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
            
            Button(action: {showEditItem = false}) {
                Text("CANCEL")
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

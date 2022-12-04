//
//  Pantry.swift
//  VirtualPantry
//
//  Created by James Dansie on 11/7/22.
//

import SwiftUI

struct Pantry: View {
    @Binding var pantryItems: [Item]
    @State var showAddItem: Bool = false;
    @State var itemName: String = ""
    @State var itemUnit: String = ""
    @State var itemAmount: String = ""
    
    var body: some View {
        VStack {
            Text("Pantry")
                .padding(.bottom)
            
            if(pantryItems.count == 0) {
                Text("No items to display")
                    .padding(.bottom)
            }
            
            List {
                ForEach(pantryItems, id: \.name) { item in
                    PantryItemRow(items: $pantryItems, item: item)
                }
            }
            
            Button(action: {showAddItem = true}) {
               Text("ADD")
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
            
            Text("Add Item to Pantry")
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
                for i in 0..<pantryItems.count {
                    if pantryItems[i].name == newItem.name {
                        newItem.quantity = newItem.quantity + pantryItems[i].quantity
                        pantryItems.remove(at: i)
                    }
                }
                pantryItems.append(newItem)
                showAddItem = false
                itemName = ""
                itemAmount = ""
                itemUnit = ""
            }) {
                Text("SAVE")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.green)
                    .cornerRadius(15.0)
            }
            
            Button(action: {
                showAddItem = false
                itemName = ""
                itemAmount = ""
                itemUnit = ""
            }) {
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
    
    struct PantryItemRow: View {
        @State var showEditItem: Bool = false;
        @State var editItemAmount: String = "";
        @State var editItemName: String = "";
        @State var editItemUnit: String = "";
        @State var updateItemAmount: String = "";
        @Binding var items: [Item]
        var item: Item
        let units = ["qty", "oz", "gal", "lbs"]

        var body: some View {
            HStack {
                Text(item.name + " (" + item.unit + ") ")
                
                Button(action: {showEditItem = true}) {
                    Text(item.quantity.codingKey.stringValue)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .popover(isPresented: $showEditItem) {
                
                Text("Quick Update")
                    .font(.headline)
                    .padding()
                
                TextField("amount", text: $updateItemAmount)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                    .padding([.leading, .bottom, .trailing], 20)
                    .keyboardType(.decimalPad)
                
                Button(action: {
                    item.quantity = item.quantity + (Int(updateItemAmount) ?? 0)
                    for i in 0..<items.count {
                        if items[i].name == item.name {
                            items.remove(at: i)
                            items.append(item)
                        }
                    }
                    showEditItem = false
                    updateItemAmount = ""
                    editItemAmount = String(item.quantity)
                }) {
                    Text("ADD/SUBTRACT")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.green)
                        .cornerRadius(15.0)
                }
                
                Text("Update " + item.name)
                    .font(.headline)
                    .padding()
                
                TextField("Item Name", text: $editItemName)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                    .padding([.leading, .bottom, .trailing], 20)
                
                Picker("Select a unit", selection: $editItemUnit) {
                    ForEach(units, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding([.leading, .bottom, .trailing], 20)
                
                TextField("amount", text: $editItemAmount)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                    .padding([.leading, .bottom, .trailing], 20)
                    .keyboardType(.decimalPad)
                
                Button(action: {
                    item.quantity = Int(editItemAmount) ?? 0
                    item.name = editItemName
                    item.unit = editItemUnit
                    for i in 0..<items.count {
                        if items[i].name == item.name {
                            items.remove(at: i)
                            items.append(item)
                        }
                    }
                    showEditItem = false
                    updateItemAmount = ""
                }) {
                    Text("SAVE")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.green)
                        .cornerRadius(15.0)
                }
                
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
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.green)
                        .cornerRadius(15.0)
                }
                
                Button(action: {
                    showEditItem = false
                    updateItemAmount = ""
                }) {
                    Text("CANCEL")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.green)
                        .cornerRadius(15.0)
                }
            }.onAppear {
                editItemName = item.name
                editItemUnit = item.unit
                editItemAmount = String(item.quantity)
            }
        }
    }
}

struct Pantry_Previews: PreviewProvider {
    static var previews: some View {
        let pantryItem1: Item = Item(name: "beans", quantity: 2, unit: "oz")
        let pantryItem2: Item = Item(name: "apple", quantity: 1, unit: "")
        let pantryItems: [Item] = [pantryItem1, pantryItem2]
        Pantry(pantryItems: .constant(pantryItems))
    }
}

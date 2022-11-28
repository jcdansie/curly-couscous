//
//  VirtualPantryApp.swift
//  VirtualPantry
//
//  Created by James Dansie on 11/3/22.
//

import SwiftUI

@main
struct VirtualPantryApp: App {
    
    @State var isLoggedIn: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                ContentView(isLoggedIn: $isLoggedIn)
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}

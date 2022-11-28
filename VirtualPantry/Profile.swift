//
//  Profiles.swift
//  VirtualPantry
//
//  Created by James Dansie on 11/7/22.
//

import SwiftUI

struct Profile: View {
    @Binding var username: String
    @Binding var firstName: String
    @Binding var lastName: String
    
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        VStack {
            Text("Profile").padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).frame(alignment: .leading)
                        
            Section {
                Text("Username: " + username)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                Text("Name: " + firstName + " " + lastName)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }
                        
            Button(action: {signOut()}) {
                Text("SIGN OUT")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.green)
                    .cornerRadius(15.0)
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            .frame(alignment: .trailing)
        }
    }
    
    func signOut() {
        isLoggedIn = false
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        let username: String = "johndoe"
        let firstName: String = "John"
        let lastName: String = "Doe"
        Profile(username: .constant(username), firstName: .constant(firstName), lastName: .constant(lastName), isLoggedIn: .constant(true))
    }
}

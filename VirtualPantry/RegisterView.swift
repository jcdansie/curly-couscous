//
//  RegisterView.swift
//  VirtualPantry
//
//  Created by James Dansie on 11/3/22.
//

import SwiftUI

struct RegisterView : View {
    @Binding var isLoggedIn: Bool
    @State var username: String = ""
    @State var password: String = ""
    @State var firstName: String = ""
    @State var lastName: String = ""
    
    var body: some View {
        
        VStack {
            RegisterText()
            
            TextField("Username", text: $username)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            TextField("First Name", text: $firstName)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            TextField("Last Name", text: $lastName)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            SecureField("Password", text: $password)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)

            Button(action: {register(username: username, firstName: firstName, lastName: lastName, password: password)}) {
                FinishRegisterButtonContent()
            }
        }
        .padding()
    }
    
    func register(username: String, firstName: String, lastName: String, password: String) {
        if (username != "" && firstName != "" && lastName != "" && password != "") {
            print("successful registration")
            isLoggedIn = true
        } else {
            print("failed registration")
        }
    }
}

struct RegisterText: View {
    var body: some View {
        Text("Register")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct FinishRegisterButtonContent: View {
    var body: some View {
        Text("REGISTER")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}


//PREVIEW
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(isLoggedIn: .constant(true))
    }
}

//
//  LoginView.swift
//  VirtualPantry
//
//  Created by James Dansie on 11/3/22.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)


struct LoginView : View {
    @Binding var isLoggedIn: Bool
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        
        NavigationView {
            VStack {
                WelcomeText()
                
                TextField("Username", text: $username)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)

                Button(action: {login(username: username, password: password)}) {
                   LoginButtonContent()
                }
                            
                Text("Don't have an account?")
                    .padding(.vertical)
                
                NavigationLink(destination: RegisterView(isLoggedIn: $isLoggedIn)) {
                       RegisterButtonContent()
                }
            }
            .padding()
        }
    }
    
    
    func login(username: String, password: String) {
        if (username != "" && password != "") {
            print("successful login")
            isLoggedIn = true
        } else {
            print("failed login")
        }
    }
}

struct WelcomeText: View {
    var body: some View {
        Text("Welcome!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct LoginButtonContent: View {
    var body: some View {
        Text("LOGIN")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}

struct RegisterButtonContent: View {
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

func navigateToRegister() {
    
}


//PREVIEW
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLoggedIn: .constant(true))
    }
}

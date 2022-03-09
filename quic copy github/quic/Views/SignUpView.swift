//
//  SignUpView.swift
//  quic
//
//  Created by Pablo Labbate on 2/28/22.
//

import SwiftUI

struct SignUpView: View {
    
    var body: some View {
        VStack {
            Text("quic")
                .font(.system(size: 80.0))
                .foregroundColor(titlePurple)
                .fontWeight(.light)
                .padding(.top, 150)
            Text("connect. quicker")
                .foregroundColor(.white)
                .font(.title3)
                .fontWeight(.thin)
                .padding(.bottom, 20)
                        
            Name()
            
            
            Email()
            
            
            Username()
            
            
            Password()
            
            
            ConfirmPassword()
            
            Button(action: {
             }) {
                 NavigationLink(destination: DashboardView()) {
                 Text("Create Account")
                         .foregroundColor(mintCream)
                         .fontWeight(.semibold)
                 }
                 .frame(maxWidth: .infinity)
                 
             }
             .padding()
             .background(mainPurple)
             .cornerRadius(6)
            
            HStack {
                Text("already have an account?")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .fontWeight(.light)
                
                
                NavigationLink (destination: LoginView()) {
                    Text("sign in!")
                        .foregroundColor(mintCream)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 150)
            .navigationTitle("") // CHANGE NAV TITLE COLOR FFS
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            

            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(mainGray)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignUpView()
        }
    }
}

struct Name: View {
    @State var name: String = ""
    
    var body: some View {
        Text("Enter name")
            .foregroundColor(mintCream)
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
        TextField("Enter name", text: $name)
            .modifier(customViewModifier(roundedCornes: 6, startColor: mainPurple, endColor: mainPurple, textColor: .white))
    }
}

struct Email: View {
    @State var email: String = ""

    var body: some View {
        Text("Enter email")
            .foregroundColor(mintCream)
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
        TextField("Enter email", text: $email)
            .modifier(customViewModifier(roundedCornes: 6, startColor: mainPurple, endColor: mainPurple, textColor: .white))
    }
}

struct Username: View {
    @State var userName: String = ""

    var body: some View {
        Text("Enter username")
            .foregroundColor(mintCream)
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
        TextField("Enter username", text: $userName)
            .modifier(customViewModifier(roundedCornes: 6, startColor: mainPurple, endColor: mainPurple, textColor: mintCream))
    }
}

struct Password: View {
    @State var password: String = ""

    var body: some View {
        Text("Enter password")
            .foregroundColor(mintCream)
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
        TextField("Enter password", text: $password)
            .modifier(customViewModifier(roundedCornes: 6, startColor: mainPurple, endColor: mainPurple, textColor: .white))
    }
}

struct ConfirmPassword: View {
    @State var retypedPassword: String = ""
    var body: some View {
        Text("Confirm password")
            .foregroundColor(mintCream)
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
        TextField("Confirm password", text: $retypedPassword)
            .modifier(customViewModifier(roundedCornes: 6, startColor: mainPurple, endColor: mainPurple, textColor: .white))
            .padding(.bottom, 10)
    }
}

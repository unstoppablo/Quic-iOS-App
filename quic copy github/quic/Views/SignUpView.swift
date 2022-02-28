//
//  SignUpView.swift
//  quic
//
//  Created by Pablo Labbate on 2/28/22.
//

import SwiftUI

struct SignUpView: View {
    @State var userName: String = ""
    @State var password: String = ""
    @State var name: String = ""
    @State var email: String = ""
    
    
    var body: some View {
        VStack {
            Spacer()
            Text("quic")
                .font(.system(size: 56.0))
                .foregroundColor(mintGreen)
                .fontWeight(.light)
                .padding(.top, 150)
            Text("connect. quicker")
                .foregroundColor(.white)
                .font(.title3)
                .fontWeight(.thin)
                .padding(.bottom, 100)
            
            Spacer()
            
            
            TextField("Enter name", text: $name)
                .modifier(customViewModifier(roundedCornes: 6, startColor: mintGreen, endColor: .white, textColor: .white))
            
            TextField("Enter email", text: $email)
                .modifier(customViewModifier(roundedCornes: 6, startColor: .white, endColor: mintGreen, textColor: .white))
            
            TextField("Enter username", text: $userName)
                .modifier(customViewModifier(roundedCornes: 6, startColor: mintGreen, endColor: .white, textColor: .white))
            
            TextField("Enter password", text: $userName)
                .modifier(customViewModifier(roundedCornes: 6, startColor: .white, endColor: mintGreen, textColor: .white))
            
            TextField("Confirm password", text: $userName)
                .modifier(customViewModifier(roundedCornes: 6, startColor: mintGreen, endColor: .white, textColor: .white))
            
            
            HStack {
                Text("already have an account?")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .fontWeight(.light)
                
                Text("sign in!")
                    .foregroundColor(mintGreen)
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            .padding(.bottom, 150)
            

            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(mainGray)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

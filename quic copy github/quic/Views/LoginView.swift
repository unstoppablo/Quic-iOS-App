//
//  LoginView.swift
//  quic
//
//  Created by Pablo Labbate on 2/28/22.
//

import SwiftUI
let mainPurple = Color(red: 0.54, green: 0.31, blue: 1.00, opacity: 1.00)
let mainGray = Color(red: 0.07, green: 0.07, blue: 0.07, opacity: 1.00)
let mintGreen = Color(red: 0.60, green: 0.98, blue: 0.60, opacity: 1.00)

let titlePurple = Color(red: 0.76, green: 0.75, blue: 0.97, opacity: 1.00)

let mintCream = Color(red: 0.94, green: 1.00, blue: 0.98, opacity: 1.00)

let lightBlue = Color(red: 0.90, green: 0.93, blue: 0.96, opacity: 1.00)

struct LoginView: View {
    @State var userName: String = ""
    @State var password: String = ""
    @State var text = ""
    


    
    var body: some View {
        NavigationView {
            
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
                        .padding(.bottom, 100)
                    
                    Spacer()
                    
        //            TextField("User name (email address)", text: $username)
        //                .padding()
        //                .disableAutocorrection(true)
        //                .autocapitalization(.none)
        //                .foregroundColor(mintGreen)
        //                .background(.white)
        //                .cornerRadius(15)
                    
                            
        //            CustomTextField(placeHolder: "Password", value: $password, lineColor: mintGreen, width: 2)
                    
                    TextField("Enter username", text: $userName)
                        .modifier(customViewModifier(roundedCornes: 6, startColor: mainPurple, endColor: mintCream, textColor: .white))
                        .keyboardType(.emailAddress)
                    
                    TextField("Enter password", text: $userName)
                        .modifier(customViewModifier(roundedCornes: 6, startColor: mintCream, endColor: mainPurple, textColor: .white))
                    
                    NavigationLink(destination: DashboardView()) {
                            Text("Log in")
                            .foregroundColor(mainPurple)
                            .fontWeight(.semibold)
                    }.navigationTitle("Sign in") // CHANGE NAV TITLE COLOR FFS
                    .padding()
                        
                    
                    HStack {
                        Text("don't have an account?")
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .fontWeight(.light)
                        
                        Text("sign up!")
                            .foregroundColor(mintCream)
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
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct CustomTextField: View {
    var placeHolder: String
    @Binding var value: String
    
    var lineColor: Color
    var width: CGFloat
    
    
    
    var body: some View {
        VStack {
           
            TextField(self.placeHolder, text: $value)
            .foregroundColor(.white)
            .padding()
            .font(.title)
            

            
            Rectangle().frame(height: self.width)
                .padding(.horizontal, 20).foregroundColor(self.lineColor)
        }
    }
}

struct customViewModifier: ViewModifier {
    var roundedCornes: CGFloat
    var startColor: Color
    var endColor: Color
    var textColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(roundedCornes)
            .padding(3)
            .foregroundColor(textColor)
//            .overlay(RoundedRectangle(cornerRadius: roundedCornes)
//                        .stroke(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2.5))
            .font(.custom("Poppins-ExtraLight", size: 18))
            
    }
}



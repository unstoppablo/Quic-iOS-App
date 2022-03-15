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
    @ObservedObject var keyboardResponder = KeyboardResponder()

    var body: some View {
//        ZStack {
//            mainGray.ignoresSafeArea()
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
                    .padding(.bottom, 45)
                    
                
                //Spacer()
                
                LogIn()
                

                
                
                SignUpRedirect()
                //Spacer(minLength: 100)

                
            }
            .padding()
            .padding(.top, 50)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(mainGray)
            .offset(y: -keyboardResponder.currentHeight*0.35)
//        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
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
//            .background(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(roundedCornes)
            .padding(3)
            .foregroundColor(textColor)
            .overlay(RoundedRectangle(cornerRadius: roundedCornes)
                        .stroke(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2.5))
            .font(.custom("Poppins-ExtraLight", size: 18))
            
    }
}



// for changing placeholder color
struct SuperTextField: View {
    
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
    
}

struct SignUpRedirect: View {
    var body: some View {
        HStack {
            Text("don't have an account?")
                .foregroundColor(.white)
                .font(.caption)
                .fontWeight(.light)
            
            NavigationLink (destination: SignUpView()) {
                Text("sign up!")
                    .foregroundColor(mintCream)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .underline(true, color: mainPurple)
            }
        }
        .navigationTitle("") // CHANGE NAV TITLE COLOR FFS
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct LogIn: View {
    //@StateObject private var loginVM = LoginViewModel()
    @State var userName: String = ""
    @State var password: String = ""
    @State var showDashboard: Bool = false

    var body: some View {
        TextField("Enter username", text: self.$userName)
            .modifier(customViewModifier(roundedCornes: 6, startColor: mainPurple, endColor: mainPurple, textColor: .white))
            .autocapitalization(.none)
            .keyboardType(.emailAddress)
        
        SecureField("Enter password", text: self.$password)
            .modifier(customViewModifier(roundedCornes: 6, startColor: mainPurple, endColor: mainPurple, textColor: .white))
            .padding(.bottom, 10)
        
        NavigationLink (destination: SignUpView()) {
            Text("Forgot password?")
                .foregroundColor(mintCream)
                .font(.caption)
                .fontWeight(.semibold)
        }
        .padding(.bottom, 20)
        .frame(maxWidth: .infinity, alignment: .trailing)
        
        Button(action: {
        }) {
            
            NavigationLink("Log in", destination: DashboardView())
                .foregroundColor(mintCream)
                .frame(maxWidth: .infinity)
            
        }
        .padding()
        .background(mainPurple)
        .cornerRadius(6)
    }
}



//func isAuthenticated(userString: String, userPassword: String) -> Bool {
//    let isUser: Bool = (userString == testUser.email || userString == testUser.username)
//    let isPassword: Bool = userString == testUser.password
//
//    return isUser && isPassword
//}

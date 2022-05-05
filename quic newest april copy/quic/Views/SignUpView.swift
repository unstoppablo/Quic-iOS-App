////
////  SignUpView.swift
////  quic
////
////  Created by Pablo Labbate on 2/28/22.
////
//import SwiftUI
//
//struct SignUpView: View {
//    @ObservedObject var keyboardResponder = KeyboardResponder()
//
//    var body: some View {
//        VStack {
//            Text("quic")
//                .font(.system(size: 80.0))
//                .foregroundColor(titlePurple)
//                .fontWeight(.light)
//                .padding(.top, 150)
//            Text("connect. quicker")
//                .foregroundColor(.white)
//                .font(.title3)
//                .fontWeight(.thin)
//                .padding(.bottom, 20)
//
//            Email()
//
//            Password()
//
//
//            ConfirmPassword()
//
//            Button(action: {
//             }) {
//                 NavigationLink(destination: DashboardView()) {
//                 Text("Create Account")
//                         .foregroundColor(mintCream)
//                         .fontWeight(.semibold)
//                 }
//                 .frame(maxWidth: .infinity)
//
//             }
//             .padding()
//             .background(mainPurple)
//             .cornerRadius(6)
//
//            HStack {
//                Text("already have an account?")
//                    .foregroundColor(.white)
//                    .font(.subheadline)
//                    .fontWeight(.light)
//
//
//                NavigationLink (destination: LoginView()) {
//                    Text("sign in!")
//                        .foregroundColor(mintCream)
//                        .font(.subheadline)
//                        .fontWeight(.semibold)
//                }
//            }
//            .padding(.bottom, 150)
//            .navigationTitle("") // CHANGE NAV TITLE COLOR FFS
//            .navigationBarHidden(true)
//            .navigationBarBackButtonHidden(true)
//
//
//
//        }
//        .padding()
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(mainGray)
//        .offset(y: -keyboardResponder.currentHeight*0.05)
//    }
//}
//
//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            SignUpView()
//        }
//    }
//}
//
//
//
//struct Email: View {
//    @State var email: String = ""
//
//    var body: some View {
//        Text("Enter email")
//            .foregroundColor(mintCream)
//            .font(.subheadline)
//            .frame(maxWidth: .infinity, alignment: .leading)
//        TextField("email", text: $email)
//            .modifier(customViewModifier(roundedCornes: 6, startColor: mainPurple, endColor: mainPurple, textColor: .white))
//            .padding(.bottom, 10)
//    }
//}
//
//
//struct Password: View {
//    @State var password: String = ""
//    @State var visible = false
//
//    var body: some View {
//        Text("Enter password")
//            .foregroundColor(mintCream)
//            .font(.subheadline)
//            .frame(maxWidth: .infinity, alignment: .leading)
//        HStack(spacing: 15) {
//
//            if self.visible {
//                TextField("password", text: self.$password)
//            }
//            else {
//                SecureField("password", text: self.$password)
//            }
//
//            Button(action: {
//                self.visible.toggle()
//            }) {
//                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
//            }
//        }
//        .modifier(customViewModifier(roundedCornes: 6, startColor: mainPurple, endColor: mainPurple, textColor: .white))
//        .padding(.bottom, 10)
//    }
//}
//
//struct ConfirmPassword: View {
//    @State var retypedPassword: String = ""
//    @State var revisible = false
//
//    var body: some View {
//        Text("Confirm password")
//            .foregroundColor(mintCream)
//            .font(.subheadline)
//            .frame(maxWidth: .infinity, alignment: .leading)
//
//        HStack(spacing: 15) {
//
//            if self.revisible {
//                TextField("password", text: self.$retypedPassword)
//            }
//            else {
//                SecureField("password", text: self.$retypedPassword)
//            }
//
//            Button(action: {
//                self.revisible.toggle()
//            }) {
//                Image(systemName: self.revisible ? "eye.slash.fill" : "eye.fill")
//            }
//        }
//        .modifier(customViewModifier(roundedCornes: 6, startColor: mainPurple, endColor: mainPurple, textColor: .white))
//        .padding(.bottom, 10)
//    }
//}
//
//

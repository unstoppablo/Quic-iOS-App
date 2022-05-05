//
//  ContentView.swift
//  realtimechat
//
//  Created by Pablo Labbate on 4/11/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore
// singleton object

let mainPurple = Color(red: 0.54, green: 0.31, blue: 1.00, opacity: 1.00)
let mainGray = Color(red: 0.07, green: 0.07, blue: 0.07, opacity: 1.00)
let mintGreen = Color(red: 0.60, green: 0.98, blue: 0.60, opacity: 1.00)

let titlePurple = Color(red: 0.76, green: 0.75, blue: 0.97, opacity: 1.00)

let mintCream = Color(red: 0.94, green: 1.00, blue: 0.98, opacity: 1.00)

let lightBlue = Color(red: 0.90, green: 0.93, blue: 0.96, opacity: 1.00)

extension Color {
    static let textColor = Color("TextColor")
    static let backgroundColor = Color("BackgroundColor")
}



func confirmPassword(password: String?, confirmPassword: String? ) -> Bool {
    if (password == "" || confirmPassword == "") {
        return false
    }
    return password == confirmPassword
}

struct LoginView: View {
    
    
    @State private var isLoginMode = false
    @State private var email = ""
    @State private var name = ""

    @State private var password = ""
    @State private var confirmPassword = ""

    @State private var shouldShowImagePicker = false
    @State var visible = false

    @State private var canProceed = false // once authenticated or acct created
    
    
    var body: some View {
        
        VStack {
            
            NavigationView {
                VStack {
                    
                    
                    Text("quic")
                        .font(.system(size: 80.0))
                        .foregroundColor(titlePurple)
                        .fontWeight(.light)
                        .padding(.top, 150)
                    Text("connect. quicker")
                        .foregroundColor(.textColor)
                        .font(.title3)
                        .fontWeight(.thin)
                        .padding(.bottom, 30)
                    
                    HStack() {
                        if !isLoginMode {
                            Button {
                                shouldShowImagePicker.toggle()
                            } label: {
                                VStack {
                                    if let image = self.image {
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 32, height: 32)
                                            .cornerRadius(32)
                                    } else {
                                        Image(systemName: "person.fill")
                                            .foregroundColor(.textColor)
                                            .font(.system(size: 32))
                                        
                                            .padding()
                                    }
                                }
                                Text("Select a profile picture.")
                                    .foregroundColor(.textColor)
                                    .font(.subheadline)
                                    .fontWeight(.light)
                            }
                            
                        }
                        
                        
                        
                    }
                    
                    
                    
                    VStack(spacing: 16) {
                        
                        Group {
                            if !isLoginMode {
                                TextField("Name", text: $name)
                                    .keyboardType(.emailAddress)
                                    .foregroundColor(.textColor)
                                    .autocapitalization(.none)
                            }
                            TextField("Email", text: $email)
                                .keyboardType(.emailAddress)
                                .foregroundColor(.textColor)
                                .autocapitalization(.none)
                            
                            
                            HStack(spacing: 15) {
                                if self.visible {
                                    TextField("Password", text: self.$password)
                                        .foregroundColor(.textColor)
                                        .autocapitalization(.none)
                                }
                                else {
                                    SecureField("Password", text: $password)
                                        .foregroundColor(.textColor)
                                        .autocapitalization(.none)
                                }

                                Button(action: {
                                    self.visible.toggle()
                                }) {
                                    Image(systemName: self.visible ? "eye.fill" : "eye.slash.fill")
                                        .foregroundColor(.textColor)
                                }
                            }
                            if !isLoginMode {
                                HStack(spacing: 15) {
                                    if self.visible {
                                        TextField("Confirm Password", text: self.$confirmPassword)
                                            .foregroundColor(.textColor)
                                            .autocapitalization(.none)
                                    }
                                    else {
                                        SecureField("Confirm Password", text: $confirmPassword)
                                            .foregroundColor(.textColor)
                                            .autocapitalization(.none)
                                    }

                                    Button(action: {
                                        self.visible.toggle()
                                    }) {
                                        Image(systemName: self.visible ? "eye.fill" : "eye.slash.fill")
                                            .foregroundColor(.textColor)

                                    }
                                }
                            }
                            
                        }
                        .modifier(customViewModifier(roundedCornes: 6, startColor: mainPurple, endColor: mainPurple, textColor: .white))
                        
                        Text("Forgot password?")
                            .foregroundColor(.textColor) // used to be mint cream
                            .font(.caption)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        

                        
                        Button {
                            handleAction()
                        } label: {
                            HStack {
                                Spacer()
                                Text(isLoginMode ? "Log in" : "Sign Up")
                                    .foregroundColor(mintCream)
                                Spacer()
                            }
                            .padding()
                            .background(mainPurple)
                            .cornerRadius(6)
                            
                        }
                        
                        
                        if isLoginMode {
                            SignUpRedirect
                        } else {
                            LoginRedirect
                        }
                        
                        Text(self.loginStatusMessage)
                            .foregroundColor(.red)
                    }
                    .padding(.bottom, 100)
                    .padding()

                    
                    
                    
                }
//                .background(.backgroundColor).ignoresSafeArea()
                .navigationTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                
//                .background(mainGray)

                
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
                ImagePicker(image: $image)
            }
        }
        .fullScreenCover(isPresented: $canProceed, onDismiss: nil) {
            ContentView()
//            if isLoginMode {
//                ContentView()
//            } else {
//                PictureSelection()
//            }
            
        }
    }
    
    @State var image: UIImage?
    
    private func handleAction () {
        if isLoginMode {
            loginUser()
//            print("should log into existing firebase acct")
        }
        else {
            createNewAccount()
//            print("should create firebase acct")
        }
    }
    
    @State var loginStatusMessage = ""
    
    private func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) {
            result, err in
            if let err = err {
                print("Failed to log in: ", err)
                self.loginStatusMessage =  "Failed to log in user: \(err)"
                return
            }
            
            print("Successfully logged in: \(result?.user.uid ?? "")")
            
            self.loginStatusMessage = "Successfuly logged in:  \(result?.user.uid ?? "")"
            self.canProceed = true
        }
    }
    
    private func createNewAccount() {
        
        if self.image == nil {
            self.loginStatusMessage = "You must select an avatar image"
            return
        }
        
        if confirmPassword(password: password, confirmPassword: confirmPassword) {
            FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, err in
                if let err = err {
                    print("Failed to create account: ", err)
                    self.loginStatusMessage =  "Failed to create user: \(err)"
                    return
                }
                
                print("Successfully created user: \(result?.user.uid ?? "")")
                
                self.loginStatusMessage = "Successfuly created user:  \(result?.user.uid ?? "")"
                
                self.persistImageToStorage()
                self.canProceed = true
            }
        } else {
            self.loginStatusMessage = "Passwords need to match."
            password = ""
            confirmPassword = ""
        }
        
    }
    
    private func persistImageToStorage() {
        
//        let filename = UUID().uuidString
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else { return }
        
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                self.loginStatusMessage = "Failed to push image to storage: \(err)"
                return
            }
            
            ref.downloadURL() { url, err in
                if let err = err {
                    self.loginStatusMessage = "Failed to  downloadURL: \(err)"
                    return
                }
                
                self.loginStatusMessage = "Successfully stored image with url: \(url?.absoluteString ?? "")"
                
                print(url?.absoluteString)
                guard let url = url else { return }
                self.storeUserInformation(imageProfile: url)
            
            }
        }
    }
    
    private func storeUserInformation(imageProfile: URL) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("couldnt get uid")
            return
        }
        
        let userData = ["email":self.email, "uid":uid, "name": self.name, "bio":"", "profileImageURL":imageProfile.absoluteString, "numSocials": 0, "followers": 0, "following":0, "socials:":[:]] as [String : Any]
        
//        let userData = ["email":self.email, "uid":uid] // og the code above this
        
        FirebaseManager.shared.firestore.collection("users").document(uid).setData(userData) { err in
            if let err = err {
                print(err)
                self.loginStatusMessage = "\(err)"
                print("something wrong")
                return
            }
            print("SUCCCC")
            
        }
    }
    
    
    var SignUpRedirect: some View {
        
        HStack {
            Text("don't have an account?")
                .foregroundColor(.textColor)
                .font(.caption)
                .fontWeight(.light)
            
            Button(action: {
                self.isLoginMode.toggle()
            }) {
                Text("Sign up!")
                    .foregroundColor(.textColor) // used to be mintcream
                    .font(.caption)
                    .fontWeight(.semibold)
                    .underline(true, color: mainPurple)
            }
            
        }
        
    }
    
    var LoginRedirect: some View {
        HStack {
            Text("already have an account?")
                .foregroundColor(.textColor)
                .font(.caption)
                .fontWeight(.light)
            
            
            Button(action: {
                self.isLoginMode.toggle()
            }) {
                Text("Log in!")
                    .foregroundColor(.textColor) // used to be mintcream
                    .font(.caption)
                    .fontWeight(.semibold)
                    .underline(true, color: mainPurple)
            }
        }
        .padding(.bottom, 20)
    }
    
}

struct ContentView_Previews1: PreviewProvider {
    static var previews: some View {
        LoginView()
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
    }
}


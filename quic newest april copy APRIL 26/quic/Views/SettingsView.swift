//
//  SettingsView.swift
//  quic
//
//  Created by Pablo Labbate on 4/10/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct SettingsView: View {
    @Binding var darkModeEnabled: Bool
    @Binding var systemThemeEnabled: Bool
    @State var shouldShowLogOutOptions = false
    @State var shouldShowSocialMediaOptions = false

    @State private var email = ""
    @State private var name = ""
    @State private var following = 0
    @State private var followers = 0
    @State private var numSocials = 0




    
    @ObservedObject private var vm = MainViewModel()
    @State var isDarkMode = true
    
    var body: some View {
        NavigationView {
            
            Form {
                
                Section(header: Text("Personal Information")) {
                    
                    
                    TextField("Email: \(vm.user?.email ?? "Email")", text: $email)
                        .keyboardType(.emailAddress)
                        .foregroundColor(.textColor)
                        .autocapitalization(.none)
                    TextField("Name: \(vm.user?.name ?? "Name")", text: $name)
                        .keyboardType(.emailAddress)
                        .foregroundColor(.textColor)
                        .autocapitalization(.none)
                    
                }
                
//                Button {
//                    shouldShowSocialMediaOptions.toggle()
//                } label: {
//                    Text("Add platform")
//                }
//                .fullScreenCover(isPresented: $shouldShowSocialMediaOptions, onDismiss: nil) {
//                    addSocialMedia()
//                }
                
                NavigationLink(destination: addSocialMedia()) {
                    Text("Add platform")
                }
                
                Section(header: Text("Display")) {
                    Toggle(isOn: $darkModeEnabled, label: {
                        Text("Dark mode")
                    })
                        .onChange(of: darkModeEnabled, perform: { _ in
                            SystemThemeManager.shared.handleTheme(darkMode: darkModeEnabled, system: systemThemeEnabled)
                        })
                    
//                    Toggle(isOn: $systemThemeEnabled, label: {
//                        Text("Use system settings")
//                    })
//                        .onChange(of: systemThemeEnabled, perform: { _ in
//                            SystemThemeManager.shared.handleTheme(darkMode: darkModeEnabled, system: systemThemeEnabled)
//                        })
                }
                
                
                Button {
                    shouldShowLogOutOptions.toggle()
                } label: {
                    Text("Sign out")
                        .foregroundColor(.red)
                        .font(.system(size: 24))
                }
            }
            .navigationTitle("Settings")
//                .navigationTitle("")
//                .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .actionSheet(isPresented: $shouldShowLogOutOptions) {
            .init(title: Text("Sign out"), message: Text(""), buttons: [.destructive(Text("Sign out"), action: {
                    print("handle sign out")
                    vm.handleSignOut()
                }), .cancel()
            ])
            }
            .fullScreenCover(isPresented: $vm.isUserCurrentlyLoggedOut, onDismiss: nil) {
            LoginView()
        }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(darkModeEnabled: .constant(false), systemThemeEnabled: .constant(true))
    }
}

struct addSocialMedia: View {
    let socialMedias = ["Facebook", "Instagram", "Twitter", "Tumblr", "Linkedin", "Github", "Tiktok", "Pinterest", "WhatsApp Business", "Youtube", "Spotify", "Soundcloud", "Other"]
    @State private var selectedMedia = ""
    @State private var username = ""
    @State private var disabled = true
//    @ObservedObject private var vm = MainViewModel()
    @State var loginStatusMessage = ""
    @State private var addPlatformResult: Bool = false
    @State var sel  = 0


    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        Picker(selection: $sel, label: Text("Select a platform")) {
//                            ForEach(socialMedias, id: \.self) {
//                                Text($0)
//                            }
                            ForEach(0 ..< socialMedias.count) { (i) in
                                HStack {
                                    Image(self.socialMedias[i])
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 45, height: 30, alignment: .leading)
                                    Text(self.socialMedias[i])
                                }.tag(i)
                            }
                            
                        }
                        .onChange(of: sel) { _ in self.disabled = false }
                        
                        
                        
                        TextField("Username", text: $username)
                            .foregroundColor(.textColor)
                            .autocapitalization(.none)
                        
                        
                    }
                    
                    Section {
                        Button {
//                            addPlatformResult = addToStorage(selectedMedia: selectedMedia, username: username)
                            addPlatformResult = addToStorage(selectedMedia: self.socialMedias[sel], username: username)
                        } label: {
                            Text("Add platform")
                        }
                        .buttonStyle(CustomButtonStyle(disabled: self.disabled))
                        
                        
                    }
                }
                if addPlatformResult {
                    Text("Account successfully added.")
                        .foregroundColor(mainPurple)
                }
            }
            
        }
    }
    
    private func addToStorage(selectedMedia: String, username: String) -> Bool {
        if username == "" {
            return false
        }
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("couldnt get uid")
            return false
        }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).setData([ "socials": [selectedMedia:username] ], merge: true)

        print("yoo")
        return true
    }
}

// source: https://stackoverflow.com/questions/56675897/changing-the-color-of-a-button-in-swiftui-based-on-disabled-or-not
struct CustomButtonStyle: ButtonStyle {
    var disabled = true
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        .foregroundColor(disabled ? .gray : .blue)
    }
}

//
//  SettingsView.swift
//  quic
//
//  Created by Pablo Labbate on 4/10/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore

func emailField(email: String?) -> String {
    if (email == "") {
        return ""
    }
    if let email = email {
        return "Email: \(email)"
    }
    else {
        return "Email"
    }
}

func nameField(name: String?) -> String {
    if (name == "") {
        return ""
    }
    if let name = name {
        return "Name: \(name)"
    }
    else {
        return "Name"
    }
}

func newNameValid(name: String?) -> Bool {
    if (name == "" || name == name) {
        return false
    }
    else {
        return true
    }
}

func newEmailValid(email: String?) -> Bool {
    if (email == "" || email == email) {
        return false
    }
    else {
        return true
    }
}

func newBioValid(bio: String?) -> Bool {
    if (bio == "" || bio == bio) {
        return false
    }
    else {
        return true
    }
}


struct SettingsView: View {
    @Binding var darkModeEnabled: Bool
    @Binding var systemThemeEnabled: Bool
    @State var shouldShowLogOutOptions = false
    @State var shouldShowSocialMediaOptions = false

    

    @State private var following = 0
    @State private var followers = 0
    @State private var numSocials = 0
    
    @State private var email = ""
    @State private var name = ""
    @State private var bio = ""
    
    @State var nameInEditMode = false
    @State var emailInEditMode = false
    @State var bioInEditMode = false
    
    @State private var isPresentingEditView = false






    
    @ObservedObject private var vm = MainViewModel()
    @State var isDarkMode = true
    
    var body: some View {
        NavigationView {
            
            Form {
                
                Section(header: Text("Personal Information")) {
                    
//                    HStack {
//                        if nameInEditMode {
//                            TextField("Email: \(vm.user?.email ?? "")", text: $email)
//                                .keyboardType(.emailAddress)
//                                .foregroundColor(.textColor)
//                                .autocapitalization(.none)
//
//
//                        } else {
//                            Text("Email: \(vm.user?.email ?? "")")
//                        }
//                        Spacer()
//                        Button(action: {
//                            self.nameInEditMode.toggle()
//                        }) {
//                            Text(nameInEditMode ? "Done" : "Edit")
//                                .foregroundColor(Color.blue)
//                        }
//                    }
                    Text("Email: \(vm.user?.email ?? "")")
                    Text("Name: \(vm.user?.name ?? "")")
                    Text("Bio: \(vm.user?.bio ?? "")")

                    
                }
                

                
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
                    

                }
                
                
                Button {
                    shouldShowLogOutOptions.toggle()
                } label: {
                    Text("Sign out")
                        .foregroundColor(.red)
                        .font(.system(size: 24))
                }
            }.toolbar {
                Button("Edit") {
                    isPresentingEditView = true
                }
            }
            .navigationTitle("Settings")
//                .navigationTitle("")
//                .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $isPresentingEditView) {
                NavigationView {
                    Form {
                        
                        Section(header: Text("Personal Information")) {
                            TextField("Email: \(vm.user?.email ?? "")", text: $email)
                                .keyboardType(.emailAddress)
                                .foregroundColor(.textColor)
                                .autocapitalization(.none)
                            TextField("Name: \(vm.user?.name ?? "")", text: $name)
                                .foregroundColor(.textColor)
                                .autocapitalization(.none)
                            TextField("Bio: \(vm.user?.bio ?? "")", text: $bio)
                                .foregroundColor(.textColor)
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem() {
                            Button("Done") {
//                                    addChangesToStorage(newEmail: email, newName: name, newBio: bio)
                                isPresentingEditView = false
                            }
                        }
                    }
                }
            }
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
    
//    private func addChangesToStorage(newEmail: String, newName: String, newBio: String)  {
//        FirebaseManager.shared.auth.currentUser?.updateEmail(to: email) { error in
//            if let error = error {
//                vm.errorMessage =  "failed update email: \(error)"
//
//                print("failed to update email: \(error)")
//                return
//            }
//        }
//
//    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(darkModeEnabled: .constant(false), systemThemeEnabled: .constant(true))
    }
}

struct addSocialMedia: View {
    let socialMedias = ["Facebook", "Instagram", "Twitter", "Tumblr", "Linkedin", "Github", "Tiktok", "Pinterest", "WhatsApp", "Youtube", "Spotify", "Soundcloud", "Other"]
    @State private var selectedMedia = ""
    @State private var username = ""
    @State private var disabled = true
//    @ObservedObject private var vm = MainViewModel()
    @State var loginStatusMessage = ""
    @State private var addPlatformResult: Bool = false
    @State var sel  = 0


    
    var body: some View {
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
                                    .frame(width: 35, height: 35, alignment: .leading)
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



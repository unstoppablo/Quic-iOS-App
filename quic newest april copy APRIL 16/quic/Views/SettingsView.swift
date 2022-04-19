//
//  SettingsView.swift
//  quic
//
//  Created by Pablo Labbate on 4/10/22.
//

import SwiftUI

struct SettingsView: View {
    @Binding var darkModeEnabled: Bool
    @Binding var systemThemeEnabled: Bool
    @State var shouldShowLogOutOptions = false


    
    @ObservedObject private var vm = MainViewModel()
    @State var isDarkMode = true
    
    var body: some View {
        NavigationView {
            
            Form {
                Section(header: Text("Display")) {
                    Toggle(isOn: $darkModeEnabled, label: {
                        Text("Dark mode")
                    })
                        .onChange(of: darkModeEnabled, perform: { _ in
                            SystemThemeManager.shared.handleTheme(darkMode: darkModeEnabled, system: systemThemeEnabled)
                        })
                    
                    Toggle(isOn: $systemThemeEnabled, label: {
                        Text("Use system settings")
                    })
                        .onChange(of: systemThemeEnabled, perform: { _ in
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
        SettingsView(darkModeEnabled: .constant(false), systemThemeEnabled: .constant(false))
    }
}

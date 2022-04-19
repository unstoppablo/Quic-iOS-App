//
//  ContentView.swift
//  quic
//
//  Created by Pablo Labbate on 2/28/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false
    @AppStorage("systemThemeEnabled") private var systemThemeEnabled = false
    
    //@StateObject private var user: LoginViewModel = LoginViewModel(user: users)
    @State private var selection = 2
    
    var body: some View {
        
        TabView(selection: $selection) {
            
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }.tag(1)
            
            DashboardView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }.tag(2)
            
            SettingsView(darkModeEnabled: $darkModeEnabled, systemThemeEnabled: $systemThemeEnabled)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }.tag(3)
        }
        .accentColor(mainPurple)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
//        .onAppear {
//            SystemThemeManager.shared.handleTheme(darkMode: darkModeEnabled, system: systemThemeEnabled)
//        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  quic
//
//  Created by Pablo Labbate on 2/28/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            NavigationLink(destination: LoginView()) {
                Text("Log in")
                .foregroundColor(mainPurple)
                .fontWeight(.semibold)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

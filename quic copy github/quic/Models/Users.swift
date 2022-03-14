//
//  User.swift
//  quic
//
//  Created by Pablo Labbate on 3/9/22.
//

import Foundation

struct User: Codable, Identifiable {
    var id = UUID()
    var name: String = "Pablo Labbate"
    var email: String = "plabbate@chapman.edu"
    private var password: String = "password2022"
    
    func getPassword() -> String {
        return password
    }
}



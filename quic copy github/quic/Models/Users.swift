//
//  User.swift
//  quic
//
//  Created by Pablo Labbate on 3/9/22.
//

import Foundation



struct User : Codable {
    var id: Int = -1
    var name: String = ""
    var username: String = ""
    private var password: String = ""
    var email: String = ""
    var following: Int = 0
    var followers: Int = 0
    var socials: [String: String] = [:]
    var bio : String = ""
    
    func getPassword() -> String {
        return password
    }
}

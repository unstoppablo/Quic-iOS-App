//
//  User.swift
//  quic
//
//  Created by Pablo Labbate on 3/9/22.
//

//import FirebaseFirestoreSwift

//import Foundation
//
//struct User: Identifiable {
//    
//    var id: String { uid }
//    
//    let uid, email, profileImageUrl: String
//    
//    init(data: [String: Any]) {
//        self.uid = data["uid"] as? String ?? ""
//        self.email = data["email"] as? String ?? ""
//        self.profileImageUrl = data["profileImageUrl"] as? String ?? ""
//    }
//}

struct User: Identifiable {
    
    var id: String { uid }
    
    let uid, email, name, bio, profileImageUrl: String
    let numSocials, followers, following: Int
    
    var socials: [String: String]
    
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.bio = data["bio"] as? String ?? ""
        self.profileImageUrl = data["profileImageURL"] as? String ?? ""
        
        self.numSocials = data["numsocials"] as? Int ?? 0
        self.followers = data["followers"] as? Int ?? 0
        self.following = data["following"] as? Int ?? 0
        
        self.socials = data["socials"] as? [String: String] ?? [:]

    }
}



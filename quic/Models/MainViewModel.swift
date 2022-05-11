//
//  MainViewModel.swift
//  quic
//
//  Created by Pablo Labbate on 4/14/22.
//

//import Foundation

//class MainViewModel: ObservableObject {
//
//    @Published var errorMessage = ""
//    @Published var user: User?
//
//    init() {
//        DispatchQueue.main.async {
//            self.isUserCurrentlyLoggedOut = FirebaseManager.shared.auth.currentUser?.uid == nil
//        }
//
//        fetchCurrentUser()
//    }
//
//    func fetchCurrentUser() {
//        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
//            self.errorMessage = "Could not find firebase uid"
//            return
//
//        }
//
//        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
//            if let error = error {
//                self.errorMessage =  "failed to fetch current user: \(error)"
//
//                print("failed to fetch current user: \(error)")
//                return
//            }
//            guard let data = snapshot?.data() else {
//                self.errorMessage = "No data found"
//                return
//
//            }
//
////            self.errorMessage = "Data: \(data.description)"
//            self.user = .init(data: data)
//
//
////            self.errorMessage = chatUser.profileImageUrl
//        }
//    }
//
//    @Published var isUserCurrentlyLoggedOut = false
//
//    func handleSignOut() {
//        isUserCurrentlyLoggedOut.toggle()
//        try? FirebaseManager.shared.auth.signOut()
//    }
//}

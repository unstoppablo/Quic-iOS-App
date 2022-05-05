//
//  DashboardView.swift
//  quic
//
//  Created by Pablo Labbate on 2/28/22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
import FirebaseFirestore




class MainViewModel: ObservableObject {

    @Published var errorMessage = ""
    @Published var user: User?

    init() {
        DispatchQueue.main.async {
            self.isUserCurrentlyLoggedOut = FirebaseManager.shared.auth.currentUser?.uid == nil
        }

        fetchCurrentUser()
        
    }

    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            print("FAILED TO FIND UID")
            return

        }

        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage =  "failed to fetch current user: \(error)"

                print("failed to fetch current user: \(error)")
                return
            }
            guard let data = snapshot?.data() else {
                print("no data found")
                self.errorMessage = "No data found"
                return

            }

//            let mappedField = snapshot.map {$0}
//            let socialsDict = mappedField?.get("socials") as! [String: String]
//            self.errorMessage = "Data: \(data.description)"
            self.user = .init(data: data)
//            self.user?.socials = socialsDict

        }
    }
    
    
    @Published var isUserCurrentlyLoggedOut = false

    func handleSignOut() {
        isUserCurrentlyLoggedOut.toggle()
        try? FirebaseManager.shared.auth.signOut()
    }
    
//    func getSocials() {
//        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
//            self.errorMessage = "Could not find firebase uid"
//            print("FAILED TO FIND UID")
//            return
//
//        }
//        
//        let db = FirebaseManager.shared.firestore.collection("users").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else if let querySnapshot = querySnapshot {
//                for document in querySnapshot.documents {
//                    let results = document.data()
//                    if let idData = results["socials"] as? [String: String] {
////                        let firstName = idData["firstName"] as? String ?? ""
////                        print(firstName)
//                        self.user?.socials = idData
//                    }
//                }
//            }
//        }
//    }
}



struct DashboardView: View {
    @State var allowDelete = false
    @ObservedObject private var vm = MainViewModel()


    var body: some View {
        
       
            //Color.black.opacity(0.1).ignoresSafeArea(.all, edges: .top)

        VStack {

            
            Section {
                TopScreen()
                
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(mainPurple)
            
            
            Section {
                
//                ScrollView{
                List {
//                    ForEach(testUser.socials.sorted(by: >), id: \.key) { key, value in
//                        linkDisplay(social: key, handler: value)
//                            .listRowSeparator(.hidden)
//
//
//                    }.onDelete(perform: delete)
                    
//                    ForEach(vm.user?.socials.sorted(by: >) ?? [String:String], id: \.key) { key, value in
//                        linkDisplay(social: key, handler: value)
//                            .listRowSeparator(.hidden)
//
//
//                    }.onDelete(perform: delete)
                    
                    

                }
                .listStyle(PlainListStyle())
                
                
                    
                    

//                }
            }
            

            
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    // source: https://stackoverflow.com/questions/70997837/delete-a-dictionary-key-and-value-through-ondeleteperform-delete
    func delete(at offsets: IndexSet){
        if let ndx = offsets.first {
            let item = testUser.socials.sorted(by: >)[ndx]
            testUser.socials.removeValue(forKey: item.key)
        }
    }
    
    
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}

struct myUser : Identifiable {
    var id: Int
    var name: String
    var password: String
    var username: String
    var email: String
    var following: Int
    var followers: Int
    var socials: [String: String] = [:]
    var bio : String = ""
}

var testUser = myUser(id: 2022, name: "John", password: "password2022", username: "johnDoe26", email: "jdoe1998@gmail.com", following: 20, followers: 35, socials: ["Facebook":"Johnathan_Doe", "Instagram":"johnDoe2022", "Twitter":"lizzardDude200", "Linkedin":"Professional Johnathan", "Github":"Coder John", "Snapchat":"SnapKingJoJo", "Tiktok":"TikkytokkyJoe"], bio: "I love hotdogs and lizzards.")

@ViewBuilder func linkDisplay(social: String, handler: String) -> some View {
    socialInfo(imageName: social, user: handler, link: social)
}

 

struct socialInfo : View {
    var imageName : String
    var user : String
    var link : String
    
    var body: some View {
        VStack {
            Button(action: {}) {
                HStack{
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 45, height: 30, alignment: .leading)
                    Link(user, destination: URL(string: "https://www.\(link).com")!)
                        .foregroundColor(.textColor)
                        .font(.subheadline)
                        
                }
                .frame(maxWidth: .infinity, idealHeight: 30, alignment: .leading)
                .padding(.bottom, 5)
                
            }
            .padding(.bottom, 5)
            
            Divider()
                .background(.white.opacity(0.5))
        }
        .padding()
        .padding(.bottom, -20)

        
//        .background(titlePurple)
//        .cornerRadius(6)
    }
}



struct TopScreen: View {
    @ObservedObject private var vm = MainViewModel()

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {

                
                WebImage(url: URL(string: vm.user?.profileImageUrl ?? ""))
                    .placeholder(Image(systemName: "person.fill"))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .clipped()
                    .cornerRadius(70)
                Spacer()
                HStack {
                    
                                            
                
//                        Spacer(minLength: 0)
                    
                    VStack {
                        Text("Socials")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(mintCream)
                        Text("\(testUser.socials.count)")
                            .font(.subheadline)
                            .fontWeight(.light)
                            .foregroundColor(mintCream)
                    }
                    Spacer(minLength: 0)
                    VStack {
                        Text("Following")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(mintCream)
                        
                        Text("\(vm.user?.following ?? 0)")
                            .font(.subheadline)
                            .fontWeight(.light)
                            .foregroundColor(mintCream)
                    }
                    
                    Spacer(minLength: 0)
                    
                    VStack {
                        Text("Followers")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(mintCream)
                        Text("\(vm.user?.followers ?? 0)")
                            .font(.subheadline)
                            .fontWeight(.light)
                            .foregroundColor(mintCream)
                    }
                }
                    
//                Spacer()
                
            }
            //                    Text("\(vm.user?.email ?? "")")
            
            Text("\(vm.user?.name ?? "could not load")")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(mintCream)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 1)
            Text(testUser.bio)
                .font(.subheadline)
                .foregroundColor(mintCream)
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }
    }
}

//
//  DashboardView.swift
//  quic
//
//  Created by Pablo Labbate on 2/28/22.
//

import SwiftUI
import SDWebImageSwiftUI

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

//            self.errorMessage = "Data: \(data.description)"
            self.user = .init(data: data)


//            self.errorMessage = chatUser.profileImageUrl
            print("USER EMAIL: \(self.user?.email)")
            print("USER ID: \(self.user?.uid)")
            print("IMAGE URL: \(self.user?.profileImageUrl)")
        }
    }

    @Published var isUserCurrentlyLoggedOut = false

    func handleSignOut() {
        isUserCurrentlyLoggedOut.toggle()
        try? FirebaseManager.shared.auth.signOut()
    }
}

struct User: Identifiable {
    
    var id: String { uid }
    
    let uid, email, profileImageUrl: String
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.profileImageUrl = data["profileImageURL"] as? String ?? ""
    }
}

struct DashboardView: View {
    
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
                        ForEach(testUser.socials.sorted(by: >), id: \.key) { key, value in
                            linkDisplay(social: key, handler: value)
                                .listRowSeparator(.hidden)
                                


                        }.onDelete(perform: delete)

                    }
                    .listStyle(PlainListStyle())
                    

//                }
            }
            .background(.background)
//            .background(Color.white.opacity(0.03))
//            .cornerRadius(15)
//            .padding()
            
        }
//        .background(mainGray)
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

//struct CircleImage: View {
//    var body: some View {
////        Image(uiImage: image)
////            .resizable()
////            .scaledToFill()
////            .frame(width: 32, height: 32)
////            .cornerRadius(32)
////        Image("\(vm.user?.image ?? "could not load")")
////            .resizable()
////            .aspectRatio(contentMode: .fill)
////            .frame(width: 90, height: 90)
//////            .cornerRadius(15)
////            .clipShape(Circle())
////            .overlay {
////                Circle().stroke(.black, lineWidth: 3)
////            }
////            .shadow(radius: 7)
//    }
//}

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
                        
                        Text("\(testUser.following)")
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
                        Text("\(testUser.followers)")
                            .font(.subheadline)
                            .fontWeight(.light)
                            .foregroundColor(mintCream)
                    }
                }
                    
//                Spacer()
                
            }
            //                    Text("\(vm.user?.email ?? "")")
            
            Text("\(vm.user?.email ?? "could not load")")
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

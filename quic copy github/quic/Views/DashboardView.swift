//
//  DashboardView.swift
//  quic
//
//  Created by Pablo Labbate on 2/28/22.
//

import SwiftUI

struct DashboardView: View {
    //@StateObject private var user : UserOO = UserOO(users: users)
    
    var body: some View {
        
        ZStack {
            //Color.black.opacity(0.1).ignoresSafeArea(.all, edges: .top)

            VStack {
                HStack {
                    Button(action: {}){
                        Image("icons8-search")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 25, height: 35)
                    }
                    Spacer(minLength: 0)
                    Button(action: {}){
                        Image("icons8-menu (2)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 25, height: 35)
                    }
                    
                }
                .padding(.top, -20) // idk if this is bad practice??
                .padding(.bottom, -20) // idk if this is bad practice??
                .padding(20)
                
                
                HStack {
                    Text("\(testUser.name)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(mainGray)
                    
                    Spacer(minLength: 0)
                }
                .padding(.top, -20)
                .padding(.bottom, -20)
                .padding(20)
                
                HStack {
                    VStack {
                        Text("Following")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)

                        Text("\(testUser.following)")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    
                    Spacer(minLength: 0)
                    
                    VStack {
                        Text("Followers")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Text("\(testUser.followers)")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    
                    
                }
                .padding(.top, -20)
                .padding(.bottom, -20)
                .padding(20)
                
                
                ZStack {
                    mainGray.ignoresSafeArea(.all, edges: .bottom)
                    
                    VStack{
                        Text(testUser.bio)
                            .padding(.top, 10)
                            .padding( 20)
                            .padding(.bottom, -10)
                            .padding(.top, -10)
                            .font(.subheadline)
                        ScrollView{
                            VStack {
                                ForEach(testUser.socials.sorted(by: >), id: \.key) { key, value in
                                    linkDisplay(social: key, handler: value)
                                }
                            }
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white.opacity(0.1))
                        
                        .cornerRadius(15)
                        .padding( 20)
                        .padding(.bottom, -20)
                        .padding(.top, -20)
                        
                    }
                }
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [mainPurple, .black]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .preferredColorScheme(.dark)
        .navigationTitle("") // SOMEHOW CHANGE COLOR
        .navigationBarHidden(true)
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
    var email: String
    var following: Int
    var followers: Int
    var socials: [String: String] = [:]
    var bio : String = ""
}

var testUser = myUser(id: 2022, name: "John", email: "jdoe1998@gmail.com", following: 20, followers: 35, socials: ["Facebook":"Johnathan_Doe", "Instagram":"johnDoe2022", "Twitter":"lizzardDude200", "LinkedIn":"Professional Johnathan"], bio: "I love hotdogs and lizzards.")

@ViewBuilder func linkDisplay(social: String, handler: String) -> some View {
    socialInfo(imageName: social, user: handler, link: social)
}

 

struct socialInfo : View {
    var imageName : String
    var user : String
    var link : String
    
    var body: some View {
        Button(action: {}) {

             HStack{
                 Image(imageName)
                     .resizable()
                     .aspectRatio(contentMode: .fit)
                     .frame(width: 50, height: 30, alignment: .leading)
                 Link(user, destination: URL(string: "https://www.\(link).com")!)
                     .foregroundColor(mainGray)
                     .font(.headline)
                 }
             .frame(maxWidth: .infinity, idealHeight: 30, alignment: .leading)
             .padding()
        }
//        .background(.white)
        .background(LinearGradient(gradient: Gradient(colors: [titlePurple, .white]), startPoint: .leading, endPoint: .bottomTrailing))
        .cornerRadius(6)
        .padding()
    }
}


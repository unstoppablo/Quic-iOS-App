//
//  DashboardView.swift
//  quic
//
//  Created by Pablo Labbate on 2/28/22.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        
        ZStack {
            mainPurple.ignoresSafeArea(.all, edges: .top)
            VStack {
                HStack {
                    Button(action: {}){
                        Image("magnifying-glass-solid")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                    }
                    Spacer(minLength: 0)
                    Button(action: {}){
                        Image("gear-solid (1)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                    }
                    
                }.padding(20)
                
                HStack {
                    Text("Dashboard")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(mainGray)
                    
                    Spacer(minLength: 0)
                }.padding(20)
                
                HStack {
                    Text("Following")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(mainGray)
                    
                    Spacer(minLength: 0)
                    
                    Text("Followers")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(mainGray)
                    
                    
                }.padding(20)
                
                
                
                ZStack {
                    mainGray.ignoresSafeArea(.all, edges: .bottom)
                    
                    VStack {
                        
                        
                        HStack {
                            Button(action: {}) {
                                 NavigationLink(destination: DashboardView()) {
                                     Image("facebook-f-brands")
                                         .resizable()
                                         .aspectRatio(contentMode: .fit)
                                         .frame(width: 50, height: 30)
                                 }

                             }
                             .padding()
                             .background(.white)
                             .cornerRadius(6)

                            
                            Button(action: {}) {
                                 NavigationLink(destination: DashboardView()) {
                                     Image("twitter-brands")
                                         .resizable()
                                         .aspectRatio(contentMode: .fit)
                                         .frame(width: 25)
                                 }
                             }
                             .padding()
                             .background(.white)
                             .cornerRadius(6)
                            
                            
                        }.padding(.top, 50)
                        Spacer()
                        HStack {
                            Text("Following")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(mainGray)
                            
                            Text("Following")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(mainGray)
                            
                            Text("Following")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(mainGray)
                        }.padding()
                        Spacer()

                        HStack {
                            Text("Following")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(mainGray)
                            
                            Text("Following")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(mainGray)
                            
                            Text("Following")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(mainGray)
                        }.padding()
                        Spacer()

                    }
                    .frame(maxWidth: .infinity)
                    .background(titlePurple)
                    
                    .cornerRadius(15)
                    .padding( 20)
                }
                
            }
            
            
        }
        
        .background(mintCream)
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

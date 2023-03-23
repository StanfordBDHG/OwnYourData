//
// This source file is part of the Stanford CardinalKit Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import FirebaseAccount
import FirebaseAuth
import SafariServices
import SwiftUI


struct HomeTabView: View {
    @State private var userName: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.accentColor)
                        .accessibilityLabel(Text("The OwnYourData App Icon"))
                        .frame(width: 240, height: 240) // Make it twice as large
                }
                .frame(width: geometry.size.width, height: geometry.size.height / 2, alignment: .top)
                Spacer().frame(height: 0)
                
                //    var body: some View {
                VStack {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .accessibilityLabel(Text("The OwnYourData App Icon"))
                        .padding()
                    
                    Text("Welcome,")
                        .offset(x: 0, y: -200)
                        .font(Font.system(size: 60))
                        .foregroundColor(Color.accentColor)
                        .fontWeight(.semibold)
                        .padding(.bottom, 1)
                    
                    Text("\(userName).")
                        .offset(x: 0, y: -200)
                        .font(Font.system(size: 60))
                        .foregroundColor(Color.accentColor)
                        .fontWeight(.medium)
                    
                    Spacer().frame(height: 0)
                    
                    VStack {
                        NavigationLink(destination: HealthRecordView()) {
                            Text("Records")
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.white)
                                .background(Color(UIColor(named: "ButtonColor_light") ?? .gray))
                                .cornerRadius(10)
                                .padding(.leading)
                                .padding(.trailing)
                        }
                        .padding(.bottom, 20)
                        
                        NavigationLink(destination: ClinicalTrialsView()) {
                            Text("Find Clinical Trials")
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .background(Color(UIColor(named: "ButtonColor_light") ?? .gray))
                                .cornerRadius(10)
                                .padding(.leading)
                                .padding(.trailing)
                        }
                    }
                    .padding(.top, -50) // Added negative padding to move the VStack closer
                }
                .padding(.bottom, 100)
                .onAppear {
                    getUserName()
                }
            }
        }
    }
    
    func getUserName() {
        if let user = Auth.auth().currentUser {
            user.reload { error in
                if let error = error {
                    print("Error reloading user: \(error.localizedDescription)")
                } else {
                    userName = user.displayName?.split(separator: " ").first.map(String.init) ?? "User"
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

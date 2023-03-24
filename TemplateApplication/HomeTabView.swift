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
        NavigationStack {
            VStack {
                LogoView()
                Text("Welcome,")
                    .font(Font.system(size: 60))
                    .foregroundColor(Color.accentColor)
                    .fontWeight(.semibold)
                    .padding(.bottom, 1)
                
                Text("\(userName).")
                    .font(Font.system(size: 60))
                    .foregroundColor(Color.accentColor)
                    .fontWeight(.semibold)
                
                Spacer()
                
                VStack {
                    NavigationLink(destination: ViewRecordsView()) {
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
                    
                    NavigationLink(destination: DocumentGalleryView()) {
                        Text("Documents")
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
            }
            .padding(.bottom, 30)
            .onAppear {
                getUserName()
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


struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}

//
// This source file is part of the Stanford CardinalKit Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import FirebaseAccount
import FirebaseAuth
import SwiftUI

struct ProfileView: View {
    let user = Auth.auth().currentUser
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
        
    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .foregroundColor(Color.accentColor)
                .scaledToFit()
                .frame(width: 120, height: 120)
                .accessibility(label: Text("profile image"))
            
            VStack {
                Text("\(firstName) \(lastName)")
                    .font(.title2)
                Text("Email: \(email)")
                    .font(.subheadline)
            }
            
            Button(action: {
                let auth = Auth.auth()
                do {
                    try auth.signOut()
                    print("Logged out.")
                } catch let signOutError as NSError {
                    print("Error signing out: %@", signOutError)
                }
            }) {
                Text("Log Out")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }.padding()
        }.onAppear {
            let defaults = UserDefaults.standard
            firstName = defaults.string(forKey: "firstName") ?? ""
            lastName = defaults.string(forKey: "lastName") ?? ""
            email = user?.email ?? ""
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

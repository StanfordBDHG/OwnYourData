//
// This source file is part of the Stanford CardinalKit Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import FirebaseAccount
import FirebaseAuth
import FirebaseFirestore
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
                .foregroundColor(Color(UIColor(named: "ButtonColor_light") ?? .gray))
                .scaledToFit()
                .frame(width: 120, height: 120)
                .accessibility(label: Text("profile image"))
            
            VStack(spacing: 10) {
                Text("\(firstName) \(lastName)")
                    .font(.title2)
                Text("Email: \(email)")
                    .font(.subheadline)
            }
            
            Spacer().frame(height: 300)
            
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
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor(named: "ButtonColor_dark") ?? .gray))
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
    
    
    func fetchUserData() {
        if let currentUser = user {
            let docRef = Firestore.firestore().collection("users").document(currentUser.uid)

            docRef.getDocument { document, _ in
                if let document = document, document.exists {
                    let data = document.data()
                    self.firstName = data?["firstName"] as? String ?? ""
                    self.lastName = data?["lastName"] as? String ?? ""
                    self.email = currentUser.email ?? ""
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

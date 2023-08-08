//
// This source file is part of the Stanford OwnYourData Application project
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
    @AppStorage(StorageKeys.firstName) var firstName = ""
    @AppStorage(StorageKeys.lastName) var lastName = ""
    @AppStorage(StorageKeys.email) var email = ""
    @AppStorage(StorageKeys.onboardingFlowComplete) var completedOnboardingFlow = false
    
    @EnvironmentObject var documentManager: DocumentManager
    
    
    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .accessibility(label: Text("profile image"))
                .foregroundColor(Color("ButtonColor_dark"))
                .frame(width: 120, height: 120)
                .padding(.top, 80)
            VStack(spacing: 10) {
                Text("\(firstName) \(lastName)")
                    .font(.title2)
                Text("Email: \(email)")
                    .font(.subheadline)
            }
            Spacer()
            OwnYourDataButton(
                title: "Log Out",
                action: {
                    do {
                        try Auth.auth().signOut()
                        
                        firstName = ""
                        lastName = ""
                        email = ""
                        
                        completedOnboardingFlow = false
                        
                        documentManager.removeAllDocuments()
                        
                        print("Logged out.")
                    } catch {
                        print("Error signing out: \(error)")
                    }
                }
            )
        }
            .padding(.bottom, 30)
            .task {
                fetchUserData()
            }
    }
    
    
    private func fetchUserData() {
        if let currentUser = Auth.auth().currentUser {
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

//
// This source file is part of the Stanford OwnYourData Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import FirebaseAuth
import FirebaseFirestore
import SpeziFirebaseAccount
import SwiftUI


struct ProfileView: View {
    @AppStorage(StorageKeys.firstName) var firstName = ""
    @AppStorage(StorageKeys.lastName) var lastName = ""
    @AppStorage(StorageKeys.email) var email = ""
    @AppStorage(StorageKeys.onboardingFlowComplete) var completedOnboardingFlow = false
    
    @EnvironmentObject var documentManager: DocumentManager
    @EnvironmentObject var fhirStandard: FHIR
    
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical) {
                VStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .accessibility(label: Text("profile image"))
                        .foregroundColor(Color("ButtonColor_dark"))
                        .frame(width: 120, height: 120)
                        .padding(.top, 40)
                    VStack(spacing: 10) {
                        Text("\(firstName) \(lastName)")
                            .font(.title2)
                        Text("Email: \(email)")
                            .font(.subheadline)
                    }
                    sharebutton
                    Spacer(minLength: 64)
                    logoutButton
                }
                    .padding(.bottom, 30)
                    .frame(minHeight: proxy.size.height)
            }
                .frame(width: proxy.size.width)
        }
            .task {
                fetchUserData()
            }
    }
    
    @ViewBuilder private var sharebutton: some View {
        VStack(alignment: .center, spacing: 8) {
            ShareLink(
                item: fhirStandard.exportPackage,
                preview: SharePreview(
                    Text("FHIR JSON Export Package")
                )
            ) {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                        .accessibilityHidden(true)
                    Text("Export")
                }
            }
                .buttonStyle(.borderedProminent)
            Text("Export your health records to share them with the OwnYourData team.")
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.accentColor)
                .font(.caption)
        }
            .padding()
    }
    
    @ViewBuilder private var logoutButton: some View {
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

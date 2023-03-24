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


struct Home: View {
    @AppStorage(StorageKeys.firstName) private var firstName = ""
    @State private var showClinicalTrialsView = false
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                LogoView()
                Text("Welcome,\n\(firstName)")
                    .font(.system(size: 60).weight(.semibold))
                    .foregroundColor(.accentColor)
                    .multilineTextAlignment(.center)
                Spacer()
                OwnYourDataButton(
                    title: "Records",
                    destination: ViewRecordsView()
                )
                OwnYourDataButton(
                    title: "Scanned Documents",
                    destination: DocumentGallery()
                )
                OwnYourDataButton(
                    title: "Find Clinical Trials",
                    action: {
                        showClinicalTrialsView = true
                    }
                )
            }
                .padding(.bottom, 30)
                .sheet(isPresented: $showClinicalTrialsView) {
                    ClinicalTrialsView()
                        .edgesIgnoringSafeArea(.all)
                }
                .task {
                    getUserName()
                }
        }
    }
    
    
    private func getUserName() {
        if let user = Auth.auth().currentUser {
            user.reload { error in
                if let error = error {
                    print("Error reloading user: \(error.localizedDescription)")
                } else {
                    firstName = user.displayName?.split(separator: " ").first.map(String.init) ?? "User"
                }
            }
        }
    }
}


struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

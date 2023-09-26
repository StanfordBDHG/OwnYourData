//
// This source file is part of the Stanford OwnYourData Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import FirebaseAuth
import SpeziFirebaseAccount
import SwiftUI


struct Home: View {
    @EnvironmentObject var fhirStandard: FHIR
    @EnvironmentObject var fhirMultipleResourceInterpreter: FHIRMultipleResourceInterpreter
    
    @AppStorage(StorageKeys.firstName) private var firstName = ""
    @State private var showClinicalTrialsView = false
    @State private var showProfileView = false
    
    
    var body: some View {
        NavigationStack { // swiftlint:disable:this closure_body_length
            ScrollView {
                VStack(spacing: 20) {
                    LogoView()
                    Text("Welcome,\n\(firstName)")
                        .font(.system(size: 60).weight(.semibold))
                        .foregroundColor(.accentColor)
                        .multilineTextAlignment(.center)
                    instructionsView
                    OwnYourDataButton(
                        title: "Match Me",
                        action: {
                            showClinicalTrialsView = true
                        }
                    )
                    OwnYourDataButton(
                        title: "Ask Questions",
                        destination: OpenAIChatView(
                            chat: fhirMultipleResourceInterpreter.askQuestionsChat(forResources: fhirStandard.resources),
                            title: "Ask Questions",
                            enableFunctionCalling: true
                        )
                    )
                    OwnYourDataButton(
                        title: "Update Information",
                        destination: DocumentGallery()
                    )
                }
            }
                .sheet(isPresented: $showClinicalTrialsView) {
                    ClinicalTrialsView()
                        .edgesIgnoringSafeArea(.all)
                }
                .sheet(isPresented: $showProfileView) {
                    ProfileView()
                }
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(
                            action: {
                                showProfileView.toggle()
                            },
                            label: {
                                Image(systemName: "person.crop.circle")
                                    .accessibilityLabel("Profile View")
                            }
                        )
                    }
                }
                .task {
                    getUserName()
                }
        }
    }
    
    
    @ViewBuilder private var instructionsView: some View {
        if fhirStandard.resources.isEmpty {
            InstructionsView()
        } else {
            LLMSummaryView()
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

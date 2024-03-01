//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SpeziAccount
import SpeziFHIR
import SpeziFHIRLLM
import SwiftUI


struct HomeView: View {
    static var accountEnabled: Bool {
        !FeatureFlags.disableFirebase && !FeatureFlags.skipOnboarding
    }

    @Environment(Account.self) var account
    @Environment(FHIRStore.self) var fjirStore

    @State private var presentingAccount = false
    @State private var showClinicalTrialsView = false

    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    LogoView()
                    welcome
                        .font(.system(size: 60).weight(.semibold))
                        .foregroundColor(.accentColor)
                        .multilineTextAlignment(.center)
                    if fjirStore.llmRelevantResources.isEmpty {
                        InstructionsView()
                    }
                    OwnYourDataButton(title: "Match Me") {
                        showClinicalTrialsView = true
                    }
                    OwnYourDataButton(
                        title: "Ask Questions",
                        destination: MultipleResourcesChatView(navigationTitle: "Ask Questions", textToSpeech: .constant(false))
                    )
                    OwnYourDataButton(
                        title: "View Your Records",
                        destination: ViewRecordsView()
                    )
                    OwnYourDataButton(
                        title: "Update Information",
                        destination: DocumentGallery()
                    )
                }
            }
                .toolbar {
                    if AccountButton.shouldDisplay {
                        AccountButton(isPresented: $presentingAccount)
                    }
                }
        }
            .sheet(isPresented: $showClinicalTrialsView) {
                ClinicalTrialsView()
                    .edgesIgnoringSafeArea(.all)
            }
            .sheet(isPresented: $presentingAccount) {
                AccountSheet()
            }
            .accountRequired(Self.accountEnabled) {
                AccountSheet()
            }
            .verifyRequiredAccountDetails(Self.accountEnabled)
    }
    
    
    @MainActor @ViewBuilder private var welcome: some View {
        if let givenName = account.details?.name?.givenName {
            Text("Welcome,\n\(givenName)")
        } else {
            Text("Welcome!")
        }
    }
}


#if DEBUG
#Preview {
    let details = AccountDetails.Builder()
        .set(\.userId, value: "lelandstanford@stanford.edu")
        .set(\.name, value: PersonNameComponents(givenName: "Leland", familyName: "Stanford"))
    
    return HomeView()
        .previewWith(standard: OwnYourDataStandard()) {
            AccountConfiguration(building: details, active: MockUserIdPasswordAccountService())
        }
}

#Preview {
    HomeView()
        .previewWith(standard: OwnYourDataStandard()) {
            AccountConfiguration {
                MockUserIdPasswordAccountService()
            }
        }
}
#endif

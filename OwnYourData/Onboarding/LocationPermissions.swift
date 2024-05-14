//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SpeziLocation
import SpeziOnboarding
import SwiftUI


struct LocationPermissions: View {
    @Environment(SpeziLocation.self) private var speziLocation
    @Environment(OnboardingNavigationPath.self) private var onboardingNavigationPath
    
    
    var body: some View {
        OnboardingView(
            contentView: {
                VStack {
                    OnboardingTitleView(
                        title: "Location Access",
                        subtitle: "Grant permission to OwnYourData to access your location."
                    )
                    Spacer()
                    Image(systemName: "location.fill")
                        .font(.system(size: 150))
                        .foregroundColor(.accentColor)
                        .accessibilityHidden(true)
                    Text("OwnYourData utilizes your location to display trials close you to.")
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 16)
                    Spacer()
                }
            }, actionView: {
                OnboardingActionsView(
                    "Grant Access",
                    action: {
                        _ = try await speziLocation.requestWhenInUseAuthorization()
                        onboardingNavigationPath.nextStep()
                    }
                )
            }
        )
            .navigationTitle("Location Access")
    }
}


#if DEBUG
#Preview {
    OnboardingStack {
        LocationPermissions()
    }
        .previewWith(standard: OwnYourDataStandard()) {
            SpeziLocation()
        }
}
#endif

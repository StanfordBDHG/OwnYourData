//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SpeziOnboarding
import SwiftUI


struct Welcome: View {
    @Environment(OnboardingNavigationPath.self) private var onboardingNavigationPath
    
    
    var body: some View {
        OnboardingView(
            title: "What We Offer",
            subtitle: "Own your health journey.",
            areas: [
                OnboardingInformationView.Content(
                    icon: {
                        Image(systemName: "apps.iphone")
                            .accessibilityHidden(true)
                    },
                    title: "Access to Your Health Records",
                    description: "Securely access your health records."
                ),
                OnboardingInformationView.Content(
                    icon: {
                        Image(systemName: "shippingbox.fill")
                            .accessibilityHidden(true)
                    },
                    title: "Trial Matching",
                    description: "Automatically match to active trials."
                ),
                OnboardingInformationView.Content(
                    icon: {
                        Image(systemName: "list.bullet.clipboard.fill")
                            .accessibilityHidden(true)
                    },
                    title: "Data Sharing",
                    description: "Share your data with trial coordinators."
                )
            ],
            actionText: "Learn More",
            action: {
                onboardingNavigationPath.nextStep()
            }
        )
            .padding(.top, 24)
    }
}


#if DEBUG
#Preview {
    OnboardingStack {
        Welcome()
    }
}
#endif

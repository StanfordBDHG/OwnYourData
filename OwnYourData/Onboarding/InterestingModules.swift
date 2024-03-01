//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SpeziOnboarding
import SwiftUI


struct InterestingModules: View {
    @Environment(OnboardingNavigationPath.self) private var onboardingNavigationPath
    
    
    var body: some View {
        SequentialOnboardingView(
            title: "How It Works",
            subtitle: "These are the steps to OwnYourData \nand connect with trials that matter.",
            content: [
                SequentialOnboardingView.Content(
                    title: "Download Your Records",
                    description: "Select your health system(s) and download your health records to your phone."
                ),
                SequentialOnboardingView.Content(
                    title: "Add Relevant Documents",
                    description: "Scan important records with the camera on your phone to complete your records."
                ),
                SequentialOnboardingView.Content(
                    title: "Discover Clinical Trials",
                    description: "Find clinical trials supported by the National Cancer Institute."
                ),
                SequentialOnboardingView.Content(
                    title: "Share Your Data",
                    description: "Control what you share and who you share it with."
                )
            ],
            actionText: "Register",
            action: {
                onboardingNavigationPath.nextStep()
            }
        )
    }
}


#if DEBUG
#Preview {
    OnboardingStack {
        InterestingModules()
    }
}
#endif

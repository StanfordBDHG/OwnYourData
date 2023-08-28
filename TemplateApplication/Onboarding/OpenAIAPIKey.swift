//
// This source file is part of the Stanford OwnYourData Application project
// Copy of the same type from the Stanford LLMonFHIR project.
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SpeziOnboarding
import SpeziOpenAI
import SwiftUI


struct OpenAIAPIKey: View {
    @EnvironmentObject private var onboardingNavigationPath: OnboardingNavigationPath
    
    
    var body: some View {
        OpenAIAPIKeyOnboardingStep {
            onboardingNavigationPath.nextStep()
        }
            .navigationBarBackButtonHidden()
            .navigationBarHidden(true)
    }
}

//
// This source file is part of the Stanford OwnYourData Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SpeziOnboarding
import SwiftUI


/// Displays an multi-step onboarding flow for the Stanford OwnYourData Applicationn.
public struct OnboardingFlow: View {
    @AppStorage(StorageKeys.onboardingFlowComplete) var completedOnboardingFlow = false
    
    
    public var body: some View {
        OnboardingStack(onboardingFlowComplete: $completedOnboardingFlow) {
            Welcome()
            InterestingModules()
            Consent()
            if !FeatureFlags.disableFirebase {
                AccountSetup()
            }
            OpenAIAPIKey()
            HealthKitPermissions()
        }
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled(!completedOnboardingFlow)
    }
    
    
    public init() {}
}


#if DEBUG
struct OnboardingFlow_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFlow()
    }
}
#endif

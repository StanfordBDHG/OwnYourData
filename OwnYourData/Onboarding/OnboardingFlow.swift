//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SpeziAccount
import SpeziFirebaseAccount
import SpeziHealthKit
import SpeziOnboarding
import SwiftUI


/// Displays an multi-step onboarding flow for the OwnYourData.
struct OnboardingFlow: View {
    @Environment(HealthKit.self) private var healthKitDataSource
    
    @AppStorage(StorageKeys.onboardingFlowComplete) private var completedOnboardingFlow = false
    
    
    private var healthKitAuthorization: Bool {
        // As HealthKit not available in preview simulator
        if ProcessInfo.processInfo.isPreviewSimulator {
            return false
        }
        
        return healthKitDataSource.authorized
    }
    
    
    var body: some View {
        OnboardingStack(onboardingFlowComplete: $completedOnboardingFlow) {
            Welcome()
            
            if !FeatureFlags.disableFirebase {
                AccountOnboarding()
            }
            
            #if !(targetEnvironment(simulator) && (arch(i386) || arch(x86_64)))
                Consent()
            #endif
            
            if HKHealthStore.isHealthDataAvailable() && !healthKitAuthorization {
                HealthKitPermissions()
            }
            
            OpenAIAPIKey()
        }
            .interactiveDismissDisabled(!completedOnboardingFlow)
    }
}


#if DEBUG
#Preview {
    OnboardingFlow()
        .environment(Account(MockUserIdPasswordAccountService()))
        .previewWith(standard: OwnYourDataStandard()) {
            OnboardingDataSource()
            HealthKit()
            AccountConfiguration {
                MockUserIdPasswordAccountService()
            }
        }
}
#endif

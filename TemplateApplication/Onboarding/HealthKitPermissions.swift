//
// This source file is part of the Stanford OwnYourData Application project
// Copy of the same type from the Stanford LLMonFHIR project.
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SpeziHealthKit
import SpeziOnboarding
import SwiftUI


struct HealthKitPermissions: View {
    @EnvironmentObject var healthKitDataSource: HealthKit
    @EnvironmentObject private var onboardingNavigationPath: OnboardingNavigationPath
    @State var healthKitProcessing = false
    
    
    var body: some View {
        OnboardingView(
            contentView: {
                VStack {
                    OnboardingTitleView(
                        title: "HEALTHKIT_PERMISSIONS_TITLE",
                        subtitle: "HEALTHKIT_PERMISSIONS_SUBTITLE"
                    )
                    Spacer()
                    Image(systemName: "heart.text.square.fill")
                        .accessibilityHidden(true)
                        .font(.system(size: 150))
                        .foregroundColor(.accentColor)
                    Text("HEALTHKIT_PERMISSIONS_DESCRIPTION")
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 16)
                    Spacer()
                }
            }, actionView: {
                OnboardingActionsView(
                    "HEALTHKIT_PERMISSIONS_BUTTON",
                    action: {
                        do {
                            healthKitProcessing = true
                            // HealthKit is not available in the preview simulator.
                            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
                                try await _Concurrency.Task.sleep(for: .seconds(5))
                            } else {
                                try await healthKitDataSource.askForAuthorization()
                            }
                        } catch {
                            print("Could not request HealthKit permissions.")
                        }
                        onboardingNavigationPath.nextStep()
                        healthKitProcessing = false
                    }
                )
            }
        )
            .padding(.top, healthKitProcessing ? 44 : 0)
            .navigationBarBackButtonHidden(healthKitProcessing)
    }
}


#if DEBUG
struct HealthKitPermissions_Previews: PreviewProvider {
    static var previews: some View {
        HealthKitPermissions()
    }
}
#endif

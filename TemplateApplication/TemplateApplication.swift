//
// This source file is part of the Stanford OwnYourData Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Spezi
import SwiftUI


@main
struct TemplateApplication: App {
    @UIApplicationDelegateAdaptor(TemplateAppDelegate.self) var appDelegate
    @AppStorage(StorageKeys.onboardingFlowComplete) var completedOnboardingFlow = false
    
    
    var body: some Scene {
        WindowGroup {
            Home()
                .sheet(isPresented: !$completedOnboardingFlow) {
                    OnboardingFlow()
                }
                .environmentObject(DocumentManager())
                .testingSetup()
                .spezi(appDelegate)
        }
    }
}

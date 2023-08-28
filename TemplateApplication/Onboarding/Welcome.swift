//
// This source file is part of the Stanford OwnYourData Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SpeziOnboarding
import SwiftUI


struct Welcome: View {
    @EnvironmentObject private var onboardingNavigationPath: OnboardingNavigationPath
    
    
    var body: some View {
        OnboardingView(
            title: "WELCOME_TITLE",
            subtitle: "WELCOME_SUBTITLE",
            areas: [
                .init(
                    icon: Image(systemName: "folder.badge.plus"),
                    title: "WELCOME_AREA1_TITLE",
                    description: "WELCOME_AREA1_DESCRIPTION"
                ),
                .init(
                    icon: Image(systemName: "magnifyingglass"),
                    title: "WELCOME_AREA2_TITLE",
                    description: "WELCOME_AREA2_DESCRIPTION"
                ),
                .init(
                    icon: Image(systemName: "square.and.arrow.up"),
                    title: "WELCOME_AREA3_TITLE",
                    description: "WELCOME_AREA3_DESCRIPTION"
                )
            ],
            actionText: "WELCOME_BUTTON",
            action: {
                onboardingNavigationPath.nextStep()
            }
        )
    }
}


#if DEBUG
struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}
#endif

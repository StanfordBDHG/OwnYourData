//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


struct AddRecordInstructView: View {
    @Environment(\.openURL) var openURL
    
    
    var body: some View {
        HowItWorks(
            steps: [
                InstructionsStep.openHealthApp,
                InstructionsStep.browseTab,
                InstructionsStep(title: "Tap \"Add Account\" to select Health System") {
                    Image("AddAccountImage")
                        .resizable()
                        .scaledToFit()
                        .accessibilityLabel(Text("Add an account in the Apple Health app."))
                        .foregroundColor(Color.accentColor)
                        .frame(width: 120, height: 120)
                        .shadow(color: .gray, radius: 4)
                        .padding(.leading, 16)
                },
                InstructionsStep(title: "Log into your health system and provide permission to \ndownload your health data to your phone")
            ]
        )
    }
}


#Preview {
    AddRecordInstructView()
}

//
// This source file is part of the Stanford OwnYourData Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


struct RecordInstructView: View {
    @Environment(\.openURL) var openURL
    
    
    var body: some View {
        HowItWorks(
            steps: [
                InstructionsStep.openHealthApp,
                InstructionsStep.browseTab,
                InstructionsStep(title: "Scroll and select Health Records to share"),
                InstructionsStep(title: "Tap \"Export PDF\" on the top right to share PDF") {
                    Text("Export PDF")
                        .foregroundColor(.blue)
                        .frame(width: 120, height: 50)
                        .background {
                            Rectangle()
                                .foregroundColor(Color(uiColor: .systemBackground))
                                .shadow(color: .gray, radius: 4)
                        }
                        .padding(.trailing, 10)
                }
            ]
        )
    }
}
struct RecordInstructView_Previews: PreviewProvider {
    static var previews: some View {
        RecordInstructView()
    }
}

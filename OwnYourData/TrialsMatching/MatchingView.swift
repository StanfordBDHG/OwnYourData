//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SpeziViews
import SwiftUI


struct MatchingView: View {
    @Environment(MatchingModule.self) private var matchingModule
    
    
    var body: some View {
        NavigationStack {
            MatchingStateView()
                .navigationTitle("Match Me")
                .toolbar {
                    AsyncButton(
                        action: {
                            await matchingModule.matchTrials()
                        },
                        label: {
                            Image(systemName: "arrow.counterclockwise")
                                .accessibilityLabel(Text("Reload Matching"))
                        }
                    )
                        .disabled(matchingModule.state.representation == .processing)
                }
                .viewStateAlert(state: matchingModule.state)
        }
    }
}


#Preview {
    MatchingView()
        .previewWith {
            MatchingModule()
        }
}

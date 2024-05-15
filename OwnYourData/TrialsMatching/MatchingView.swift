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
            Group {
                if matchingModule.matchingTrials.isEmpty || matchingModule.state.representation == .processing {
                    MatchingStateView()
                } else {
                    List {
                        Section {
                            ForEach(matchingModule.matchingTrials, id: \.self) { trial in
                                TrialView(trial: trial)
                            }
                        }
                    }
                }
            }
                .navigationTitle("Match Me")
                .toolbar {
                    if !(matchingModule.matchingTrials.isEmpty || matchingModule.state.representation == .processing) {
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

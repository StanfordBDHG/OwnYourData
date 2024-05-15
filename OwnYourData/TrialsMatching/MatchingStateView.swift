//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


private struct MatchingstateLogo: View {
    let image: String
    let text: LocalizedStringResource
    
    var body: some View {
        VStack {
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 200)
                .foregroundStyle(.accent)
                .padding()
                .accessibilityHidden(true)
            Text(text)
            ProgressView()
                .padding()
        }
    }
}


struct MatchingStateView: View {
    @Environment(MatchingModule.self) private var matchingModule
    
    
    var body: some View {
        switch matchingModule.state {
        case .idle:
            VStack {
                LogoView()
                Text("Use the OwnYourData algorithm to match you to possible NCI trials.")
                    .multilineTextAlignment(.center)
                    .padding()
                Button("Start Matching") {
                    Task {
                        await matchingModule.matchTrials()
                    }
                }
            }
            
        case .fhirInspection:
            MatchingstateLogo(
                image: "text.magnifyingglass",
                text: "Inspecting FHIR resources ..."
            )
        case .nciLoading:
            MatchingstateLogo(
                image: "network",
                text: "Loading NCI trials based on FHIR resources ..."
            )
        case .matching:
            MatchingstateLogo(
                image: "wand.and.stars.inverse",
                text: "Identifying best matching trials ..."
            )
        case .error:
            VStack {
                Image(systemName: "x.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 200)
                    .foregroundStyle(.red)
                    .accessibilityHidden(true)
                    .padding()
                Text("Error matching you to NCI trials. Please try again.")
            }
        }
    }
}


#Preview {
    MatchingStateView()
        .previewWith {
            MatchingModule()
        }
}

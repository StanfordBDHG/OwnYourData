//
// This source file is part of the Stanford OwnYourData Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SpeziOpenAI
import SpeziViews
import SwiftUI


struct LLMSummaryView: View {
    @EnvironmentObject var fhirStandard: FHIR
    @EnvironmentObject var openAIComponent: OpenAIComponent
    @EnvironmentObject var fhirMultipleResourceInterpreter: FHIRMultipleResourceInterpreter
    
    @State private var summary: String?
    @State private var viewState: ViewState = .idle
    
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "magnifyingglass")
                .accessibilityHidden(true)
                .font(.system(size: 90))
                .foregroundColor(.accentColor)
                .padding(.vertical, 8)
            VStack(alignment: .leading, spacing: 8) {
                Text("INTRO_FUNCTIONALITY")
                if viewState == .processing {
                    VStack(alignment: .center) {
                        ProgressView()
                        Text("SUMMARY_LOADING")
                            .font(.caption)
                            .frame(maxWidth: .infinity)
                    }
                } else if let summary {
                    Text(summary)
                }
                Text("INSTRUCTIONS_WITH_RESOURCES")
            }
                .frame(maxWidth: .infinity)
        }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color(UIColor.systemGroupedBackground))
                    .shadow(radius: 5)
            )
            .padding()
            .onReceive(fhirStandard.objectWillChange) {
                loadSummary()
            }
            .onAppear {
                loadSummary()
            }
    }
    
    
    private func loadSummary() {
        guard viewState != .processing else {
            return
        }
        
        Task {
            viewState = .processing
            do {
                self.summary = try await fhirMultipleResourceInterpreter.generateSummary(forResources: fhirStandard.resources)
                viewState = .idle
            } catch {
                viewState = .error("Could not load the resource summary: \(error)")
            }
        }
    }
}

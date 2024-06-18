//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import OpenAPIClient
import SwiftUI
import SpeziLLM
import SpeziLLMOpenAI


struct TrialView: View {
    @Environment(LLMRunner.self) var runner
    
    let trial: TrialDetail
    @State var isExpanded = false
    @State var llmSummary: String?
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(trial.briefTitle ?? "No Title")
                .bold()
            Text(trial.id ?? "No NCI ID")
                .bold()
                .foregroundStyle(.secondary)
            DisclosureGroup(isExpanded: $isExpanded) {
                Text(llmSummary ?? "Still loading the summary ...")
                    .font(.caption)
            } label: {
                Text("Details")
                    .foregroundColor(.blue)
            }
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
                .task {
                    await generateLLMSummary()
                }
        }
    }
    
    
    fileprivate func generateLLMSummary() async {
        // Instantiate the `LLMOpenAISchema` to an `LLMOpenAISession` via the `LLMRunner`.
        let llmSession: LLMOpenAISession = runner(
            with: LLMOpenAISchema(
                parameters: .init(
                    modelType: .gpt4_turbo_preview,
                    systemPrompt: "Please summarize this text: \(trial.detailDescription ?? ""). Please only ..."
                )
            )
        )
        
        do {
            var response = ""
            for try await token in try await llmSession.generate() {
                response.append(token)
            }
            llmSummary = response
        } catch {
            llmSummary = trial.detailDescription
        }
    }
}

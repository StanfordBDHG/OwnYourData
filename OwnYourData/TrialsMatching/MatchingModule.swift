//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import OpenAPIClient
import Spezi
import SpeziFHIR
import SpeziFHIRLLM
import SpeziLLM
import SpeziLLMOpenAI
import SpeziLocalStorage
import SpeziLocation
import SpeziViews
import SwiftUI


@Observable
class MatchingModule: Module, EnvironmentAccessible, DefaultInitializable {
    public enum Defaults {
        public static var llmSchema: LLMOpenAISchema {
            LLMOpenAISchema(parameters: LLMOpenAIParameters(modelType: .gpt4_turbo_preview))
        }
    }
    
    
    @ObservationIgnored @Dependency private var localStorage: LocalStorage
    @ObservationIgnored @Dependency private var llmRunner: LLMRunner
    @ObservationIgnored @Dependency private var fhirStore: FHIRStore
    @ObservationIgnored @Dependency private var locationModule: SpeziLocation
    @ObservationIgnored @Dependency private var nciTrialsModel: NCITrialsModule?

    @ObservationIgnored @Model private var resourceSummary: FHIRResourceSummary
    
    var state: MatchingState = .idle
    private(set) var matchingTrials: [TrialDetail] = []
    private var keywords: [String] = []
    
    
    required init() {}
    
    
    func configure() {
        resourceSummary = FHIRResourceSummary(
            localStorage: localStorage,
            llmRunner: llmRunner,
            llmSchema: Defaults.llmSchema
        )
    }
    
    
    @MainActor
    func matchTrials() async {
        do {
            guard let nciTrialsModel else {
                fatalError("Error that NCI Trials Module was not initialized in the Spezi Configuratin.")
            }
            
            withAnimation {
                self.state = .fhirInspection
            }
            let keywords = try await keywordIdentification()
            withAnimation {
                self.state = .nciLoading
            }
            try await nciTrialsModel.fetchTrials(keywords: keywords)
            if nciTrialsModel.trials.isEmpty {
                try await nciTrialsModel.fetchTrials()
            }
            withAnimation {
                self.state = .matching
            }
            let matchingTrialIds = try await trialsIdentificaiton()
            
            matchingTrials = nciTrialsModel.trials.filter { trial in matchingTrialIds.contains(where: { $0 == trial.llmIdentifier }) }
            
            withAnimation {
                self.state = .idle
            }
        } catch {
            withAnimation {
                self.state = .error(AnyLocalizedError(error: error))
            }
        }
    }
    
    @MainActor
    private func keywordIdentification() async throws -> [String] {
        let llm = llmRunner(
            with: LLMOpenAISchema(parameters: .init(modelType: .gpt4_turbo_preview)) {
                GetFHIRResourceLLMFunction(
                    fhirStore: self.fhirStore,
                    resourceSummary: self.resourceSummary,
                    resourceCountLimit: 100
                )
            }
        )
        
        llm.context.append(systemMessage: FHIRPrompt.keywordIdentification.prompt)
        
        if let patient = fhirStore.patient {
            llm.context.append(systemMessage: patient.jsonDescription)
        }
        
        guard let stream = try? await llm.generate() else {
            return []
        }
        
        var output = ""
        for try await token in stream {
            output.append(token)
        }
        
        keywords = output.components(separatedBy: ",").flatMap { $0.components(separatedBy: " ") }.filter { !$0.isEmpty }
        return keywords
    }
    
    @MainActor
    private func trialsIdentificaiton() async throws -> [String] {
        guard let nciTrialsModel else {
            fatalError("Error that NCI Trials Module was not initialized in the Spezi Configuratin.")
        }
        
        let llm = llmRunner(
            with: LLMOpenAISchema(parameters: .init(modelType: .gpt4_turbo_preview)) {
                GetFHIRResourceLLMFunction(
                    fhirStore: self.fhirStore,
                    resourceSummary: self.resourceSummary,
                    resourceCountLimit: 100
                )
                GetTrialsLLMFunction(nciTrialsModel: nciTrialsModel)
            }
        )
        
        llm.context.append(systemMessage: FHIRPrompt.trialMatching.prompt)
        
        if let patient = fhirStore.patient {
            llm.context.append(systemMessage: patient.jsonDescription)
        }
        
        if !keywords.isEmpty {
            llm.context.append(systemMessage: String(localized: "Identified Keywords: \(keywords.joined(separator: ", "))"))
        }
        
        guard let stream = try? await llm.generate() else {
            return []
        }
        
        var output = ""
        for try await token in stream {
            output.append(token)
        }
        
        return output.components(separatedBy: ",")
    }
}

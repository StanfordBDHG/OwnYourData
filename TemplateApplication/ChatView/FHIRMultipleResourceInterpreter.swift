//
// This source file is part of the Stanford OwnYourData Application project
// File originates from the Stanford LLMonFHIR project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import OpenAI
import Spezi
import SpeziLocalStorage
import SpeziOpenAI
import SwiftUI


private enum FHIRMultipleResourceInterpreterConstants {
    static let storageKey = "FHIRMultipleResourceInterpreter.Cache"
}


class FHIRMultipleResourceInterpreter: DefaultInitializable, Component, ObservableObject, ObservableObjectProvider {
    @Dependency private var localStorage: LocalStorage
    @Dependency private var openAIComponent = OpenAIComponent()
    
    
    var interpretation: String? {
        willSet {
            Task { @MainActor in
                objectWillChange.send()
            }
        }
        didSet {
            do {
                try localStorage.store(interpretation, storageKey: FHIRMultipleResourceInterpreterConstants.storageKey)
            } catch {
                print(error)
            }
        }
    }
    
    
    required init() {}
    
    
    func configure() {
        guard let cachedInterpretation: String = try? localStorage.read(
            storageKey: FHIRMultipleResourceInterpreterConstants.storageKey
        ) else {
            return
        }
        self.interpretation = cachedInterpretation
    }
    
    
    func askQuestionsChat(forResources resources: [FHIRResource]) -> [Chat] {
        var resourceCategories = String()
        
        for resource in resources {
            resourceCategories += (resource.functionCallIdentifier + "\n")
        }

        return [
            Chat(
                role: .system,
                content: Prompt.allResources.prompt.replacingOccurrences(of: Prompt.promptPlaceholder, with: resourceCategories)
            )
        ]
    }
    
    
    func generateSummary(forResources resources: [FHIRResource]) async throws -> String {
        var resourceCategories = String()
        
        for resource in resources {
            resourceCategories += (resource.functionCallIdentifier + "\n")
        }
        
        let chat = [
            Chat(
                role: .system,
                content: Prompt.summary.prompt.replacingOccurrences(of: Prompt.promptPlaceholder, with: resourceCategories)
            )
        ]
        
        let chatStreamResults = try await openAIComponent.queryAPI(withChat: chat)
        var summary = ""
        for try await chatStreamResult in chatStreamResults {
            for choice in chatStreamResult.choices {
                summary += choice.delta.content ?? ""
            }
        }
        
        return summary
    }
}

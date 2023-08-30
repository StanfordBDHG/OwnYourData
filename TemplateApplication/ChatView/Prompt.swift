//
// This source file is part of the Stanford OwnYourData Application project
// File originates from the Stanford LLMonFHIR project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Foundation


enum Prompt: String {
    /// The summary prompt
    case summary = "prompt.summary"
    /// The API call prompt
    case interpretation = "prompt.apicall"
    /// The resources interpretation prompt
    case allResources = "prompt.allResources"
    
    
    static let promptPlaceholder = "%@"
    
    
    var localizedDescription: String {
        switch self {
        case .summary:
            return String(localized: "PROMPT_DESCRIPTION_SUMMARY")
        case .interpretation:
            return String(localized: "PROMPT_DESCRIPTION_APICALL")
        case .allResources:
            return String(localized: "PROMPT_DESCRIPTION_ALLRESOURCES")
        }
    }
    
    var defaultPrompt: String {
        switch self {
        case .summary:
            return String(localized: "PROMPT_PROMPT_SUMMARY \("%@")")
        case .interpretation:
            return String(localized: "PROMPT_PROMPT_APICALL \("%@")")
        case .allResources:
            return String(localized: "PROMPT_PROMPT_ALLRESOURCES \("%@")")
        }
    }
    
    
    var prompt: String {
        UserDefaults.standard.string(forKey: rawValue) ?? defaultPrompt
    }
    
    func save(prompt: String) {
        UserDefaults.standard.set(prompt, forKey: rawValue)
    }
}

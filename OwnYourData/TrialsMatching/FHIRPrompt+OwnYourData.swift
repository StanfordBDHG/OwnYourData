//
// This source file is part of the OwnYourData based on the SpeziFHIR project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SpeziFHIRLLM


extension FHIRPrompt {
    static let keywordIdentification: FHIRPrompt = {
        FHIRPrompt(
            storageKey: "prompt.keywordIdentification",
            localizedDescription: String(
                localized: "Keyword Identification Prompt",
                comment: "Title of the keyword identification prompt."
            ),
            defaultPrompt: String(
                localized: "Keyword Identification Prompt Content",
                comment: "Content of the keyword identification prompt."
            )
        )
    }()
    
    static let trialMatching: FHIRPrompt = {
        FHIRPrompt(
            storageKey: "prompt.trialMatching",
            localizedDescription: String(
                localized: "Trial Matching Prompt",
                comment: "Title of the trial matching prompt."
            ),
            defaultPrompt: String(
                localized: "Trial Matching Prompt Content",
                comment: "Content of the trial matching prompt."
            )
        )
    }()
}

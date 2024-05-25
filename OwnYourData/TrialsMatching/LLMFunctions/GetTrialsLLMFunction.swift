//
// This source file is part of the OwnYourData based on the SpeziFHIR project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import os
import SpeziFHIR
import SpeziFHIRLLM
import SpeziLLMOpenAI


struct GetTrialsLLMFunction: LLMFunction {
    static let logger = Logger(subsystem: "edu.stanford.cs342.ownyourdata", category: "GetTrialLLMFunction")
    
    static let name = "get_trials"
    static let description = String(localized: "LLM_GET_TRIALS_FUNCTION_DESCRIPTION")
    
    private let nciTrialsModel: NCITrialsModule
    
    
    @Parameter var trailIdentifiers: [String]
    
    
    init(
        nciTrialsModel: NCITrialsModule
    ) {
        self.nciTrialsModel = nciTrialsModel
                
        _trailIdentifiers = Parameter(
            description: String(localized: "LLM_GET_TRIALS_PARAMETER_DESCRIPTION"),
            enum: nciTrialsModel.trials.compactMap { $0.llmIdentifier }
        )
    }
    
    
    func execute() async throws -> String? {
        trailIdentifiers
            .compactMap { trailIdentifier in
                nciTrialsModel.trials.first(where: { $0.llmIdentifier == trailIdentifier })
                    .map { trial in
                        """
                        **Trial \(trailIdentifier)**
                        
                        Title: \(trial.briefTitle ?? "") (\(trial.officialTitle ?? ""))
                        Description: \(trial.detailDescription ?? "")
                        Incluision Criteria: \(trial.eligibility?.unstructured?.compactMap { $0.description }.joined() ?? "")
                        """
                    }
            }
            .joined(separator: "\n\n\n")
    }
}

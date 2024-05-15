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
    static let description = String(localized: "GET_TRIALS_FUNCTION_DESCRIPTION")
    
    private let nciTrialsModel: NCITrialsModel
    
    
    @Parameter var trailIDs: [String]
    
    
    init(
        nciTrialsModel: NCITrialsModel
    ) {
        self.nciTrialsModel = nciTrialsModel
        
        _trailIDs = Parameter(
            description: String(localized: "GET_TRIALS_PARAMETER_DESCRIPTION"),
            enum: nciTrialsModel.trials.compactMap({ $0.nciId })
        )
    }
    
    
    func execute() async throws -> String? {
        trailIDs
            .compactMap { trailId in
                nciTrialsModel.trials.first(where: { $0.nciId == trailId })
                    .map { trial in
                        """
                        **Trial \(trailId)**
                        
                        Title: \(trial.briefTitle ?? "") (\(trial.officialTitle ?? ""))
                        Description: \(trial.detailDescription ?? "")
                        Incluision Criteria: \(trial.eligibility?.unstructured?.compactMap({ $0.description }).joined() ?? "")
                        """
                    }
            }
            .joined(separator: "\n\n\n")
    }
}
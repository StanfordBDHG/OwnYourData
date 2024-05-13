//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Foundation
import SpeziHealthKit
import SpeziLLM
import SpeziLLMOpenAI

class ClinicalTrialLLM {
    func extractKeywordsFromHealthRecords() async {
        do {
            let healthRecords = try await accessHealthRecords()
            let keywords = try await extractKeywords(from: healthRecords)
            ClinicalTrialsView.keywords = keywords
        } catch {
            print("Error extracting keywords from health records : \(error)")
        }
    }
    
    func extraxtPhaseFromHealthData(healthData: HealthData) {
        
    }
    
    private func accessHealthRecords() async throws -> HealthRecords {
        // access patient health data from SpeziHealthKit
    }
    
    private func extractKeywords(from healthRecords: HealthRecords) async throws -> [String] {
        // get keywords from health records through call to OpenAI's api using SpeziLLMOpenAI
    }
}

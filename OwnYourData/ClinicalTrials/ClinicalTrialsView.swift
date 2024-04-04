//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//
import Foundation
import SwiftUI
struct ClinicalTrialsView: View {
    @State private var trials: [ClinicalTrial] = []
        
    var body: some View {
        VStack {
            if trials.isEmpty {
                Text("Loading...")
                    .onAppear {
                        fetchClinicalTrials { fetchedTrials in
                            trials = fetchedTrials
                        }
                    }
            } else {
                List(trials) { trial in
                    VStack(alignment: .leading) {
                        Text(trial.data.officialTitle)
                            .font(.headline)
                        Text(trial.data.briefSummary)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}
func fetchClinicalTrials(completion: @escaping ([ClinicalTrial]) -> Void) {
    // Parameters for the API Call
    let apiKey = "rQexsvuEeX62RJHrNO5Ex8HKzLx1iDUT34CL3DJA"
    let responseSize = 1
    
    guard let url = URL(string: "https://clinicaltrialsapi.cancer.gov/api/v2/trials?size=" + String(responseSize) + "&sites.recruitment_status=ACTIVE") else {
        completion([])
        return
    }
    
    let headers = [
        "accept": "*/*",
        "X-API-KEY": apiKey
    ]
    
    var request = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        if let error = error {
            print("Error: \(error)")
            completion([])
            return
        }
        guard let data = data else {
            print("No data received")
            completion([])
            return
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Received JSON: \(jsonString)")
        }
        do {
            let decodedData = try JSONDecoder().decode([ClinicalTrial].self, from: data)
            // Store trials in a JSON file (e.g., UserDefaults, File system, etc.)
            // For simplicity, this example will just call the completion with the result
            completion(decodedData)
        } catch {
            print("Error decoding JSON: \(error)")
            completion([])
        }
    }
    task.resume()
}
// MARK: - ClinicalTrial
struct ClinicalTrial: Decodable, Identifiable {
    let id: String
    let total: Int
    let data: Datum
}
// MARK: - Datum
struct Datum: Decodable {
    let interventionalModel, leadOrg: String
    let eligibility: Eligibility
    let sites: [Site]
    let detailDescription, officialTitle: String
    let outcomeMeasures: [OutcomeMeasure]
    let phase: String
    let primaryPurpose: String
    let nctID: String
    let biomarkers: [Biomarker]
    let diseases: [Disease]
    let activeSitesCount: Int
    let arms: [Arm]
    let nciID: String
    let briefSummary, briefTitle: String
    let minimumTargetAccrualNumber: Int
    let priorTherapy: [PriorTherapy]
    let currentTrialStatusSortOrder: Int
    let startDate, recordVerificationDate, ctepID, currentTrialStatus: String
    let masking: Masking
    let anatomicSites: [String]
    let startDateTypeCode, principalInvestigator, studySource, completionDate: String
    let studyProtocolType: String
}
// MARK: - Arm
struct Arm: Decodable {
    let interventions: [Intervention]
    let name, armDescription, type: String
}
// MARK: - Intervention
struct Intervention: Decodable {
    let inclusionIndicator: InclusionIndicator
    let synonyms: [String]
    let nciThesaurusConceptID, name: String
    let interventionDescription: String?
    let type: InterventionType
    let category: Category
    let parents: [String]
}
enum Category: String, Decodable {
    case agent
    case agentCategory
    case other
}
enum InclusionIndicator: String, Decodable {
    case tree
    case trial
}
enum InterventionType: String, Decodable {
    case biologicalVaccine
    case drug
    case other
    case procedureSurgery
}
// MARK: - Biomarker
struct Biomarker: Decodable {
    let eligibilityCriterion: EligibilityCriterion
    let inclusionIndicator: InclusionIndicator
    let synonyms: [String]
    let nciThesaurusConceptID, name: String
    let semanticTypes: [SemanticType]
    let type: [BiomarkerType]
    let ancestors, parents: [String]
    let assayPurpose: AssayPurpose
}
enum AssayPurpose: String, Decodable {
    case eligibilityCriterionExclusion
    case eligibilityCriterionInclusion
}
enum EligibilityCriterion: String, Decodable {
    case exclusion
    case inclusion
}
enum SemanticType: String, Decodable {
    case cellOrMolecularDysfunction
    case finding
    case geneOrGenome
    case laboratoryOrTestResult
}
enum BiomarkerType: String, Decodable {
    case branch
    case referenceGene
}
// MARK: - Disease
struct Disease: Decodable {
    let inclusionIndicator: InclusionIndicator
    let isLeadDisease: Bool
    let synonyms: [String]
    let nciThesaurusConceptID, name: String
    let type: [DiseaseType]
    let parents: [String]
}
enum DiseaseType: String, Decodable {
    case maintype
    case stage
    case subtype
}
// MARK: - Eligibility
struct Eligibility: Decodable {
    let unstructured: [Unstructured]
    let structured: Structured
}
// MARK: - Structured
struct Structured: Decodable {
    let maxAge: String
    let maxAgeNumber: Int
    let minAgeUnit, maxAgeUnit: String
    let maxAgeInYears: Int
    let gender: String
    let acceptsHealthyVolunteers: Bool
    let minAge: String
    let minAgeNumber, minAgeInYears: Int
}
// MARK: - Unstructured
struct Unstructured: Decodable {
    let inclusionIndicator: Bool
    let displayOrder: Int
    let unstructuredDescription: String
}
// MARK: - Masking
struct Masking: Decodable {
    let masking, allocationCode: String
}
// MARK: - OtherID
struct OtherID {
    let name, value: String
}
// MARK: - OutcomeMeasure
struct OutcomeMeasure: Decodable {
    let timeframe, name: String
    let outcomeMeasureDescription: String
    let typeCode: TypeCode
}
enum TypeCode: String, Decodable {
    case otherPreSpecified
    case primary
    case secondary
}
// MARK: - PriorTherapy
struct PriorTherapy: Decodable {
    let eligibilityCriterion: EligibilityCriterion
    let inclusionIndicator: InclusionIndicator
    let synonyms: [String]
    let nciThesaurusConceptID, name: String
    let ancestorIDS, parents: [String]
}
// MARK: - Site
struct Site: Decodable {
    let orgStateOrProvince: String
    let contactName: String
    let contactPhone: String
    let orgPostalCode: String
    let contactEmail: String
    let recruitmentStatus: String
    let orgCity, orgEmail: String
    let orgCountry: String
    let orgFax, orgPhone: String
    let orgName: String
    let orgCoordinates: OrgCoordinates
}
// MARK: - OrgCoordinates
struct OrgCoordinates: Decodable {
    let lon, lat: Double
}
#Preview {
    ClinicalTrialsView()
}

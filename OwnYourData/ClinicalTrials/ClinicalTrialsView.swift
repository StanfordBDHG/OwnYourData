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
    @State private var clinicalTrial: ClinicalTrial?
        
    var body: some View {
        VStack {
            if let trial = clinicalTrial {
                List {
                    ForEach(trial.data.indices, id: \.self) { index in
                        let datum = trial.data[index]
                        VStack(alignment: .leading) {
                            Text(datum.officialTitle)
                                .font(.headline)
                            Text(datum.briefSummary)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            fetchClinicalTrials()
        }
    }
}
func fetchClinicalTrials() {
    // Parameters for the API Call
    let apiKey = "rQexsvuEeX62RJHrNO5Ex8HKzLx1iDUT34CL3DJA"
    let responseSize = 1
    
    guard let url = URL(string: "https://clinicaltrialsapi.cancer.gov/api/v2/trials?size=" + String(responseSize) + "&sites.recruitment_status=ACTIVE") else {
        print("Invalid URL")
        return
    }
    
    let headers = [
        "accept": "*/*",
        "X-API-KEY": apiKey
    ]
    
    var request = URLRequest(url: url)
    request.allHTTPHeaderFields = headers
    
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        if let error = error {
            print("Error: \(error)")
            return
        }
        guard let data = data else {
            print("No data received: \(error?.localizedDescription ?? "Unkown error")")
            return
        }
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Received JSON: \(jsonString)")
        }
        
        do {
            let decodedData = try JSONDecoder().decode(ClinicalTrial.self, from: data)
        } catch {
            // Getting a KeyNotFound Error here
            print("Error decoding JSON: \(error)")
        }
    }.resume()
}

// MARK: - ClinicalTrial
struct ClinicalTrial: Codable {
    let total: Int
    let data: [Datum]
}
// MARK: - Datum
struct Datum: Codable, Identifiable, Hashable {
    var id = UUID() // Identifier for each datum
    let interventionalModel, leadOrg: String
    let eligibility: Eligibility
    let sites: [Site]
    let detailDescription: String
    let officialTitle: String
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
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
    }
    
    static func == (lhs: Datum, rhs: Datum) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
// MARK: - Arm
struct Arm: Codable {
    let interventions: [Intervention]
    let name, armDescription, type: String
}
// MARK: - Intervention
struct Intervention: Codable {
    let inclusionIndicator: InclusionIndicator
    let synonyms: [String]
    let nciThesaurusConceptID, name: String
    let interventionDescription: String?
    let type: InterventionType
    let category: Category
    let parents: [String]
}
enum Category: String, Codable {
    case agent
    case agentCategory
    case other
}
enum InclusionIndicator: String, Codable {
    case tree
    case trial
}
enum InterventionType: String, Codable {
    case biologicalVaccine
    case drug
    case other
    case procedureSurgery
}
// MARK: - Biomarker
struct Biomarker: Codable {
    let eligibilityCriterion: EligibilityCriterion
    let inclusionIndicator: InclusionIndicator
    let synonyms: [String]
    let nciThesaurusConceptID, name: String
    let semanticTypes: [SemanticType]
    let type: [BiomarkerType]
    let ancestors, parents: [String]
    let assayPurpose: AssayPurpose
}
enum AssayPurpose: String, Codable {
    case eligibilityCriterionExclusion
    case eligibilityCriterionInclusion
}
enum EligibilityCriterion: String, Codable {
    case exclusion
    case inclusion
}
enum SemanticType: String, Codable {
    case cellOrMolecularDysfunction
    case finding
    case geneOrGenome
    case laboratoryOrTestResult
}
enum BiomarkerType: String, Codable {
    case branch
    case referenceGene
}
// MARK: - Disease
struct Disease: Codable {
    let inclusionIndicator: InclusionIndicator
    let isLeadDisease: Bool
    let synonyms: [String]
    let nciThesaurusConceptID, name: String
    let type: [DiseaseType]
    let parents: [String]
}
enum DiseaseType: String, Codable {
    case maintype
    case stage
    case subtype
}
// MARK: - Eligibility
struct Eligibility: Codable {
    let unstructured: [Unstructured]
    let structured: Structured
}
// MARK: - Structured
struct Structured: Codable {
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
struct Unstructured: Codable {
    let inclusionIndicator: Bool
    let displayOrder: Int
    let unstructuredDescription: String
}
// MARK: - Masking
struct Masking: Codable {
    let masking, allocationCode: String
}
// MARK: - OtherID
struct OtherID {
    let name, value: String
}
// MARK: - OutcomeMeasure
struct OutcomeMeasure: Codable {
    let timeframe, name: String
    let outcomeMeasureDescription: String
    let typeCode: TypeCode
}
enum TypeCode: String, Codable {
    case otherPreSpecified
    case primary
    case secondary
}
// MARK: - PriorTherapy
struct PriorTherapy: Codable {
    let eligibilityCriterion: EligibilityCriterion
    let inclusionIndicator: InclusionIndicator
    let synonyms: [String]
    let nciThesaurusConceptID, name: String
    let ancestorIDS, parents: [String]
}
// MARK: - Site
struct Site: Codable {
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
struct OrgCoordinates: Codable {
    let lon, lat: Double
}
#Preview {
    ClinicalTrialsView()
}

//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Foundation
import SwiftUI

//
struct ClinicalTrialsView: View {
    @State private var trials: [ClinicalTrial] = []
        
    var body: some View {
        VStack {
            if trials.isEmpty {
                Text("Loading...")
                    .onAppear {
                        fetchClinicalTrials { fetchedTrials in
                            if let fetchedTrials = fetchedTrials {
                                self.trials = fetchedTrials
                            }
                        }
                    }
            } else {
                List(trials) { trial in
                    VStack(alignment: .leading) {
                        Text(trial.data.officialTitle ?? "Unknown Title")
                            .font(.headline)
                        Text(trial.data.briefSummary ?? "No Summary Available")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                }
            }
        }
    }
}

func fetchClinicalTrials(completion: @escaping ([ClinicalTrial]?) -> Void) {
    // Parameters for the API Call
    let apiKey = "rQexsvuEeX62RJHrNO5Ex8HKzLx1iDUT34CL3DJA"
    let responseSize = 3
    
    guard let url = URL(string: "https://clinicaltrialsapi.cancer.gov/api/v2/trials?size=" + String(responseSize) + "&sites.recruitment_status=ACTIVE") else {
        completion(nil)
        return
    }
    
    let headers = [
        "accept": "*/*",
        "X-API-KEY": apiKey
    ]
    
    var request = URLRequest(url: url)

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print(error)
        } else if let data = data {
            let str = String(data: data, encoding: .utf8)
            print(str ?? "")
        }

        do {
            let trials = try JSONDecoder().decode([ClinicalTrial].self, from: data!)
            // Store trials in a JSON file (e.g., UserDefaults, File system, etc.)
            // For simplicity, this example will just call the completion with the result
            completion(trials)
        } catch {
            print("Error decoding JSON: \(error)")
            completion(nil)
        }
    }
    task.resume()
}

// MARK: - ClinicalTrial
struct ClinicalTrial: Decodable, Identifiable {
    let id: String
    let total: Int
    let data: [Datum]
}

// MARK: - Datum
struct Datum {
    let otherIDS: [OtherID]
    let amendmentDate: String
    let keywords, dcpID: NSNull
    let interventionalModel, leadOrg: String
    let eligibility: Eligibility
    let sites: [Site]
    let completionDateTypeCode, detailDescription, officialTitle: String
    let phaseSortOrder: Int
    let collaborators: [Collaborator]
    let associatedStudies: [AssociatedStudy]
    let outcomeMeasures: [OutcomeMeasure]
    let phase: String
    let centralContact: CentralContact
    let primaryPurpose: String
    let numberOfArms, studyProtocolTypeSortOrder: Int
    let nctID: String
    let biomarkers: [Biomarker]
    let classificationCode: String?
    let currentTrialStatusDate: String
    let diseases: [Disease]
    let primaryPurposeSortOrder: Int
    let protocolID: String
    let activeSitesCount: Int
    let leadOrgCancerCenter: NSNull
    let arms: [Arm]
    let studyModelCode: NSNull
    let nciID: String
    let whyStudyStopped: NSNull
    let briefSummary, briefTitle: String
    let statusHistory: [StatusHistory]
    let studyPopulationDescription, samplingMethodCode: NSNull
    let minimumTargetAccrualNumber: Int
    let priorTherapy: [PriorTherapy]
    let currentTrialStatusSortOrder: Int
    let startDate, recordVerificationDate, ctepID, currentTrialStatus: String
    let studyModelOtherText: NSNull
    let masking: Masking
    let acronym: NSNull
    let nciPrograms: [String]
    let nciFunded: String
    let anatomicSites: [String]
    let ccrID: NSNull
    let startDateTypeCode, principalInvestigator, studySource, completionDate: String
    let studySubtypeCode: NSNull
    let studyProtocolType: String
}

// MARK: - Arm
struct Arm {
    let interventions: [Intervention]
    let name, armDescription, type: String
}

// MARK: - Intervention
struct Intervention {
    let inclusionIndicator: InclusionIndicator
    let synonyms: [String]
    let nciThesaurusConceptID, name: String
    let interventionDescription: String?
    let type: InterventionType
    let category: Category
    let parents: [String]
}

enum Category {
    case agent
    case agentCategory
    case other
}

enum InclusionIndicator {
    case tree
    case trial
}

enum InterventionType {
    case biologicalVaccine
    case drug
    case other
    case procedureSurgery
}

// MARK: - AssociatedStudy
struct AssociatedStudy {
    let studyIDType, studyID: String
}

// MARK: - Biomarker
struct Biomarker {
    let eligibilityCriterion: EligibilityCriterion
    let inclusionIndicator: InclusionIndicator
    let synonyms: [String]
    let nciThesaurusConceptID, name: String
    let semanticTypes: [SemanticType]
    let type: [BiomarkerType]
    let ancestors, parents: [String]
    let assayPurpose: AssayPurpose
}

enum AssayPurpose {
    case eligibilityCriterionExclusion
    case eligibilityCriterionInclusion
}

enum EligibilityCriterion {
    case exclusion
    case inclusion
}

enum SemanticType {
    case cellOrMolecularDysfunction
    case finding
    case geneOrGenome
    case laboratoryOrTestResult
}

enum BiomarkerType {
    case branch
    case referenceGene
}

// MARK: - CentralContact
struct CentralContact {
    let phone, name, type, email: NSNull
}

// MARK: - Collaborator
struct Collaborator {
    let name, functionalRole: String
}

// MARK: - Disease
struct Disease {
    let inclusionIndicator: InclusionIndicator
    let isLeadDisease: Bool
    let synonyms: [String]
    let nciThesaurusConceptID, name: String
    let type: [DiseaseType]
    let parents: [String]
}

enum DiseaseType {
    case maintype
    case stage
    case subtype
}

// MARK: - Eligibility
struct Eligibility {
    let unstructured: [Unstructured]
    let structured: Structured
}

// MARK: - Structured
struct Structured {
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
struct Unstructured {
    let inclusionIndicator: Bool
    let displayOrder: Int
    let unstructuredDescription: String
}

// MARK: - Masking
struct Masking {
    let roleCaregiver: NSNull
    let masking, roleInvestigator: String?
    let roleOutcomeAssessor: NSNull
    let roleSubject: String?
    let allocationCode: String
}

// MARK: - OtherID
struct OtherID {
    let name, value: String
}

// MARK: - OutcomeMeasure
struct OutcomeMeasure {
    let timeframe, name: String
    let outcomeMeasureDescription: String?
    let typeCode: TypeCode
}

enum TypeCode {
    case otherPreSpecified
    case primary
    case secondary
}

// MARK: - PriorTherapy
struct PriorTherapy {
    let eligibilityCriterion: EligibilityCriterion
    let inclusionIndicator: InclusionIndicator
    let synonyms: [String]
    let nciThesaurusConceptID, name: String
    let ancestorIDS, parents: [String]
}

// MARK: - Site
struct Site {
    let orgStateOrProvince: OrgStateOrProvince
    let contactName: ContactName
    let contactPhone: String?
    let recruitmentStatusDate: String
    let orgAddressLine2: String?
    let orgVa: Bool
    let orgAddressLine1: String
    let orgTTY, orgFamily: String?
    let orgPostalCode: String
    let contactEmail: String?
    let recruitmentStatus: RecruitmentStatus
    let orgCity: String
    let orgEmail: String?
    let orgCountry: OrgCountry
    let orgFax, orgPhone: String?
    let orgName: String
    let orgCoordinates: OrgCoordinates?
}

enum ContactName {
    case brianLeslieBurnette
    case gregoryAndrewMasters
    case jamesEarlRadford
    case joseABufill
    case prestonDSteen
    case sitePublicContact
}

// MARK: - OrgCoordinates
struct OrgCoordinates {
    let lon, lat: Double
}

enum OrgCountry {
    case canada
    case unitedStates
}

enum OrgStateOrProvince {
    case ak
    case al
    case ar
    case az
    case britishColumbia
    case ca
    case co
    case ct
    case dc
    case de
    case fl
    case ga
    case gu
    case hi
    case ia
    case id
    case il
    case ks
    case ky
    case la
    case ma
    case md
    case me
    case mi
    case mn
    case mo
    case ms
    case mt
    case nc
    case nd
    case ne
    case newBrunswick
    case nh
    case nj
    case nm
    case nv
    case ny
    case oh
    case ok
    case ontario
    case or
    case orgStateOrProvinceIN
    case pa
    case pr
    case quebec
    case ri
    case saskatchewan
    case sc
    case sd
    case tn
    case tx
    case ut
    case va
    case vt
    case wa
    case wi
    case wv
    case wy
}

enum RecruitmentStatus {
    case active
    case closedToAccrual
    case closedToAccrualAndIntervention
    case completed
    case temporarilyClosedToAccrual
    case withdrawn
}

// MARK: - StatusHistory
struct StatusHistory {
    let statusDate, status: String
}

#Preview {
    ClinicalTrialsView()
}

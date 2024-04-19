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
                    ForEach(trial.data, id: \.nctID) { datum in
                        VStack(alignment: .leading) {
                            Text(datum.briefTitle ?? "No title available")
                                .font(.headline)
                            Text(datum.briefSummary ?? "No summary available")
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
    
    func fetchClinicalTrials() {
        // Parameters for the API Call
        let apiKey = "rQexsvuEeX62RJHrNO5Ex8HKzLx1iDUT34CL3DJA"
        let responseSize = 1
        
        guard let url = URL(string: "https://clinicaltrialsapi.cancer.gov/api/v2/trials?size=\(responseSize)&sites.recruitment_status=ACTIVE") else {
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
            do {
                let decodedData = try JSONDecoder().decode(ClinicalTrial.self, from: data)
                print("decoded data retrieved, calling updateClinicalTrial")
                print(decodedData)
                updateClinicalTrial(decodedData)
            } catch {
                // Getting a KeyNotFound Error here
                print("Error decoding JSON: \(error)")
            }
        }
        task.resume()
    }
    
    func updateClinicalTrial(_ decodedData: ClinicalTrial) {
        print("in the updateClinicalTrial func")
        DispatchQueue.main.async {
            clinicalTrial = decodedData // Update the state variable
            print("updated the state variable")
        }
    }

}

// MARK: - ClinicalTrial
struct ClinicalTrial: Codable {
    let total: Int
    let data: [Datum]
}
// MARK: - Datum
struct Datum: Codable, Hashable {
    let eligibility: Eligibility
    let sites: [Site]
    let detailDescription: String?
    let phase: String?
    let primaryPurpose: String?
    let nctID: String?
    let diseases: [Disease]
    let nciID: String?
    let briefSummary: String?
    let briefTitle: String?
    let currentTrialStatus: String?
    let studyProtocolType: String?
      
    static func == (lhs: Datum, rhs: Datum) -> Bool {
        return lhs.nctID == rhs.nctID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(nctID)
    }
}

// MARK: - Eligibility
struct Eligibility: Codable {
    let unstructured: [Unstructured]
    let structured: Structured
}
// MARK: - Unstructured
struct Unstructured: Codable {
    let inclusionIndicator: Bool?
    let unstructuredDescription: String?
}
// MARK: - Structured
struct Structured: Codable {
    let maxAgeInYears: Int?
    let gender: String?
    let acceptsHealthyVolunteers: Bool?
    let minAgeInYears: Int?
}

// MARK: - Site
struct Site: Codable {
    let orgStateOrProvince: String?
    let contactName: String?
    let contactPhone: String?
    let orgPostalCode: String?
    let contactEmail: String?
    let recruitmentStatus: String?
    let orgCity: String?
    let orgEmail: String?
    let orgCountry: String?
    let orgPhone: String?
    let orgName: String?
    let orgCoordinates: OrgCoordinates?
}
// MARK: - OrgCoordinates
struct OrgCoordinates: Codable {
    let lon, lat: Double?
}

// MARK: - Disease
struct Disease: Codable {
    let isLeadDisease: Bool?
    let synonyms: [String]?
    let nciThesaurusConceptID: String?
    let name: String?
    let parents: [String]?
}

#Preview {
    ClinicalTrialsView()
}

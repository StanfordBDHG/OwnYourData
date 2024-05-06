//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import OpenAPIClient
import SpeziViews
import SwiftUI


struct ClinicalTrialsView: View {
    @State private var viewState: ViewState = .idle
    @State private var trials: [TrialDetail] = []
    
    
    var body: some View {
        if let url = URL(string: "https://www.cancer.gov/about-cancer/treatment/clinical-trials/search") {
            WebView(url: url)
                .task {
                    trials.append(contentsOf: (try? await loadTrials().data) ?? [])
                    // await testNCIAPI()
                }
                .viewStateAlert(state: $viewState)
        }
    }
    
    
    private func testNCIAPI() async {
        do {
            let testTrialIds = [
                "NCI-2019-02616",
                "NCT03386721",
                "NCI-2015-00414",
                "NCI-2016-00376",
                "NCI-2016-00469",
                "NCI-2017-00679",
                "NCI-2018-02229",
                "NCI-2016-01319",
                "NCI-2016-01435",
                "NCI-2017-00223",
                "NCT03391791",
                "NCT02369029",
                "NCT02877862",
                "NCT02565758",
                "NCT03110159",
                "NCT02896907",
                "NCT02816697",
                "NCT03092856"
            ]
            viewState = .processing
            for testTrialId in testTrialIds {
                trials.append(try await loadTrial(withId: testTrialId))
                try await Task.sleep(for: .seconds(2))
            }
            viewState = .idle
        } catch {
            viewState = .error(AnyLocalizedError(error: error))
        }
    }
        
    private func loadTrial(withId trialId: String) async throws -> TrialDetail {
        OpenAPIClientAPI.customHeaders = ["X-API-KEY": "tkMGxBkgOC4TDCUfjcPdw7eeZsuuZual632WpUnH"]
        CodableHelper.dateFormatter = NICTrialsAPIDateFormatter()
        
        return try await withCheckedThrowingContinuation { continuation in
            TrialsAPI.getTrialById(id: trialId) { data, error in
                guard let data else {
                    if let error {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(throwing: DownloadException.responseFailed)
                    }
                    return
                }
                
                continuation.resume(returning: data)
            }
        }
    }
    
    private func loadTrials() async throws -> TrialResponse {
        OpenAPIClientAPI.customHeaders = ["X-API-KEY": "tkMGxBkgOC4TDCUfjcPdw7eeZsuuZual632WpUnH"]
        CodableHelper.dateFormatter = NICTrialsAPIDateFormatter()
        
        return try await withCheckedThrowingContinuation { continuation in
            TrialsAPI.searchTrialsByGet(
                size: 1,
                keyword: "breast",
                trialStatus: "OPEN",
                primaryPurpose: "TREATMENT",
                sitesOrgCoordinatesLat: 37.7749,
                sitesOrgCoordinatesLon: -122.4194,
                sitesOrgCoordinatesDist: "100mi"
            ) { data, error in
                guard let data else {
                    if let error {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(throwing: DownloadException.responseFailed)
                    }
                    return
                }
                
                continuation.resume(returning: data)
            }
        }
    }
}


#Preview {
    ClinicalTrialsView()
}

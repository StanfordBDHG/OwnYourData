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
        List {
            if trials.isEmpty {
                ProgressView()
            } else {
                ForEach(trials) { trial in
                    VStack(alignment: .leading) {
                        Text(trial.briefTitle ?? "No Title")
                            .bold()
                        Text(trial.id ?? "No NCI ID")
                            .bold()
                            .foregroundStyle(.secondary)
                        Divider()
                        Text(trial.detailDescription ?? "-")
                            .font(.caption)
                    }
                }
            }
        }
            .navigationTitle("NCI Trials")
            .task {
                trials.append(contentsOf: (try? await loadTrials().data) ?? [])
            }
            .viewStateAlert(state: $viewState)
    }
    
    
    private func loadTrials() async throws -> TrialResponse {
        OpenAPIClientAPI.customHeaders = ["X-API-KEY": ""]
        CodableHelper.dateFormatter = NICTrialsAPIDateFormatter()
        
        return try await withCheckedThrowingContinuation { continuation in
            TrialsAPI.searchTrialsByGet(
                size: 50,
                keyword: "breast",
                trialStatus: "OPEN",
                phase: "III",
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

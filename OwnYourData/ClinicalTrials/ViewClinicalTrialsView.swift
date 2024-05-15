//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import CoreLocation
import OpenAPIClient
import SpeziLocation
import SpeziViews
import SwiftUI


struct ViewClinicalTrialsView: View {
    @Environment(NCITrialsModel.self) private var nciTrialsModel
    
    @State private var viewState: ViewState = .idle
    
    
    var body: some View {
        NavigationStack {
            content
                .task {
                    await fetchTrials()
                }
                .viewStateAlert(state: $viewState)
                .navigationTitle("NCI Trials")
        }
    }
    
    @ViewBuilder @MainActor private var content: some View {
        switch viewState {
        case .processing, .error:
            VStack {
                ProgressView()
                    .padding()
                Text("Loading NCI Trials")
            }
        case .idle:
            if nciTrialsModel.trials.isEmpty {
                Text("No trials found.")
            } else {
                List {
                    searchSection
                    Section {
                        ForEach(nciTrialsModel.trials, id: \.self) { trial in
                            TrialView(trial: trial)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder @MainActor private var searchSection: some View {
        @Bindable var nciTrialsModel = nciTrialsModel
        Section {
            LabeledContent {
                TextField("Enter Zip Code", text: $nciTrialsModel.zipCode)
            } label: {
                Text("Zip Code:")
                    .bold()
            }
            LabeledContent {
                TextField("Enter Distance (mi)", text: $nciTrialsModel.searchDistance)
            } label: {
                Text("Distance:")
                    .bold()
            }
            HStack {
                Spacer()
                AsyncButton("Update Search", state: $viewState) {
                    await fetchTrials()
                }
                Spacer()
            }
        }
            .disabled(viewState == .processing)
    }
    
    
    private func fetchTrials() async {
        viewState = .processing // Set loading state
        
        do {
            try await nciTrialsModel.fetchTrials()
            viewState = .idle
        } catch {
            viewState = .error(AnyLocalizedError(error: error))
        }
    }
}


#Preview {
    ViewClinicalTrialsView()
}

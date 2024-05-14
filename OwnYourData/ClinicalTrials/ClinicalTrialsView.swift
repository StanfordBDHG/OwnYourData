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


struct ClinicalTrialsView: View {
    @Environment(SpeziLocation.self) private var speziLocation
    
    @State private var viewState: ViewState = .idle
    @State private var trials: [TrialDetail] = []
    @State private var zipCode: String = "10025"
    @State private var searchDistance: String = "100"
    
    
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
//        switch viewState {
//        case .processing, .error:
//            VStack {
//                ProgressView()
//                Text("Loading NCI Trials")
//            }
//        case .idle:
//            if trials.isEmpty {
//                Text("No trials found.")
//            } else {
                List {
                    searchSection
                    Section {
                        ForEach(trials, id: \.self) { trial in
                            TrialView(trial: trial)
                        }
                    }
                }
//            }
//        }
    }
    
    @ViewBuilder @MainActor private var searchSection: some View {
        Section {
            LabeledContent {
                TextField("Enter Zip Code", text: $zipCode)
            } label: {
                Text("Zip Code:")
                    .bold()
            }
            LabeledContent {
                TextField("Enter Distance (mi)", text: $searchDistance)
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
        
    // Function to convert zip code to coordinates
    private func getLocationFromZipCode(zipCode: String) async -> CLLocation? {
        do {
            let placemarks = try await CLGeocoder().geocodeAddressString(zipCode)
            if let location = placemarks.first?.location {
                return location
            }
        } catch {
            print("Error converting zip code to coordinates: \(error)")
        }
        return nil
    }
    
    // Function to convert coordinates to zip code
    private func getZipCodeFromLocation(location: CLLocation) async {
        do {
            let placemarks = try await CLGeocoder().reverseGeocodeLocation(location)
            if let postalCode = placemarks.first?.postalCode {
                zipCode = postalCode
            } else {
                print("Postal code not found in placemark")
            }
        } catch {
            print("Reverse geocoding failed with error: \(error.localizedDescription)")
        }
    }
    
    // Function to load the trials from NCI API
    private func loadTrials(coordinate: CLLocationCoordinate2D?) async throws -> TrialResponse {
        OpenAPIClientAPI.customHeaders = ["X-API-KEY": "tkMGxBkgOC4TDCUfjcPdw7eeZsuuZual632WpUnH"]
        CodableHelper.dateFormatter = NICTrialsAPIDateFormatter()
        
        return try await withCheckedThrowingContinuation { continuation in
            TrialsAPI.searchTrialsByGet(
                size: 50,
                keyword: "breast",
                trialStatus: "OPEN",
                phase: "III",
                primaryPurpose: "TREATMENT",
                sitesOrgCoordinatesLat: coordinate?.latitude,
                sitesOrgCoordinatesLon: coordinate?.longitude,
                sitesOrgCoordinatesDist: searchDistance + "mi"
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
    
    
    private func fetchTrials() async {
        viewState = .processing // Set loading state
        
        // Reload trials with updated search parameters
        trials.removeAll() // Clear existing trials
        
        // Fetch trials with updated parameters
        var coordinate: CLLocationCoordinate2D?
        
        if let userLocation = try? await speziLocation.getLatestLocations().first {
            coordinate = userLocation.coordinate
            await getZipCodeFromLocation(location: userLocation)
        } else if let location = await getLocationFromZipCode(zipCode: zipCode) {
            coordinate = location.coordinate
        }
        
        do {
            trials = try await loadTrials(coordinate: coordinate).data ?? []
            viewState = .idle
        } catch {
            viewState = .error(AnyLocalizedError(error: error))
        }
    }
}


#Preview {
    ClinicalTrialsView()
}

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
    @State private var collapseStates: [Bool] = [] // Track collapsed state for each trial
    @State private var zipCode: String = "98155" // ZipCode search state variable, defaults to 10025
    @State private var searchDistance: String = "100" // Distance search state variable, default 100
    
    
    var body: some View {
        NavigationStack {
            content
                .onAppear {
                    Task {
                        // Start fetching trials when the view appears
                        await fetchTrials()
                    }
                }
                .viewStateAlert(state: $viewState)
        }
    }
    
    @ViewBuilder private var content: some View {
        switch viewState {
        case .processing:
            ProgressView()
        case let .error(error):
            Text("Error: \(error.localizedDescription)")
        case .idle:
            if trials.isEmpty {
                Text("No trials found.")
            } else {
                VStack(spacing: 10) {
                    // Horizontal bar for changing zip code and distance
                    searchBar
                    
                    List {
                        ForEach(trials.indices, id: \.self) { index in
                            TrialView(trial: trials[index], isCollapsedDescription: $collapseStates[index])
                        }
                    }
                    .navigationTitle("NCI Trials")
                }
            }
        }
    }
    
    @ViewBuilder private var searchBar: some View {
        if viewState == .idle {
            VStack(alignment: .leading, spacing: 4) {
                // Label for Zip Code
                Text("Zip Code (e.g. 10025)")
                    .padding(.leading)
                // Text field for Zip Code
                TextField("Enter Zip Code", text: $zipCode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // Label for Search Distance
                Text("Search Distance (e.g. 100)")
                    .padding(.leading)
                // Text field for Search Distance
                TextField("Enter Distance (mi)", text: $searchDistance)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // Update Search button
                Button("Update Search") {
                    Task {
                        // Perform search with updated zip code and distance
                        await fetchTrials()
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
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
        OpenAPIClientAPI.customHeaders = ["X-API-KEY": ""]
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
    
    // Function to update search parameters
    private func fetchTrials() async {
        viewState = .processing // Set loading state
        
        // Reload trials with updated search parameters
        trials.removeAll() // Clear existing trials
        collapseStates.removeAll() // Clear existing collapse states
        
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
            collapseStates = Array(repeating: false, count: trials.count)
            viewState = .idle
        } catch {
            viewState = .error(AnyLocalizedError(error: error))
        }
    }
}


#Preview {
    ClinicalTrialsView()
}

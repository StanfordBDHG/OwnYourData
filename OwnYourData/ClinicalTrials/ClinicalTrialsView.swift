//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import CoreLocation
import OpenAPIClient
import SpeziViews
import SwiftUI

struct ClinicalTrialsView: View {
    @State private var viewState: ViewState = .idle
    @State private var trials: [TrialDetail] = []
    @State private var collapseStates: [Bool] = [] // Track collapsed state for each trial
    @State private var zipCode: String = "98155" // ZipCode search state variable, defaults to 10025
    @State private var searchDistance: String = "100" // Distance search state variable, default 100
    
    // Create a CLLocationManager instance to manage location services for trials match search
    private let locationManager = CLLocationManager()
    // Create a CLGeocoder instance to convert zip code to coordinates
    private let geocoder = CLGeocoder()
    
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
    
    @ViewBuilder
    private var content: some View {
        switch viewState {
        case .processing:
            ProgressView()
        case .error(let error):
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
    
    @ViewBuilder
    private var searchBar: some View {
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
            let placemarks = try await geocoder.geocodeAddressString(zipCode)
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
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
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
    private func loadTrials(latitude: Double, longitude: Double, zipCode: String, distance: String) async throws -> TrialResponse {
        OpenAPIClientAPI.customHeaders = ["X-API-KEY": ""]
        CodableHelper.dateFormatter = NICTrialsAPIDateFormatter()
        
        return try await withCheckedThrowingContinuation { continuation in
            TrialsAPI.searchTrialsByGet(
                size: 50,
                keyword: "breast",
                trialStatus: "OPEN",
                phase: "III",
                primaryPurpose: "TREATMENT",
                sitesOrgCoordinatesLat: latitude,
                sitesOrgCoordinatesLon: longitude,
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
        
        locationManager.requestWhenInUseAuthorization()
        
        // Reload trials with updated search parameters
        trials.removeAll() // Clear existing trials
        collapseStates.removeAll() // Clear existing collapse states
        
        // Fetch trials with updated parameters
        Task {
            var latitude: Double = 0
            var longitude: Double = 0
            if let userLocation = locationManager.location {
                // Use userLocation if available
                latitude = userLocation.coordinate.latitude
                longitude = userLocation.coordinate.longitude
                
                // Get Zip Code from user's current location
                await getZipCodeFromLocation(location: userLocation)
            } else {
                // Convert zip code to coordinates if user location is not available
                if let location = await getLocationFromZipCode(zipCode: zipCode) {
                    latitude = location.coordinate.latitude
                    longitude = location.coordinate.longitude
                }
            }
            // Fetch trials based on obtained coordinates
            do {
                let trialResponse = try await loadTrials(
                    latitude: latitude,
                    longitude: longitude,
                    zipCode: zipCode,
                    distance: searchDistance
                )
                trials = trialResponse.data ?? []
                // Initialize collapse states for each trial
                collapseStates = Array(repeating: false, count: trials.count)
            } catch {
                viewState = .error(error as? LocalizedError ?? FetchingError.unknownError) // Set error state
            }
            
            if viewState == .processing {
                viewState = .idle // Set idle state if not already set by an error
            }
        }
    }
}

struct TrialView: View {
    let trial: TrialDetail
    @Binding var isCollapsedDescription: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(trial.briefTitle ?? "No Title")
                .bold()
            Text(trial.id ?? "No NCI ID")
                .bold()
                .foregroundStyle(.secondary)
            DisclosureGroup(isExpanded: $isCollapsedDescription) {
                Text(trial.detailDescription ?? "-")
                    .font(.caption)
            } label: {
                Text("Details")
                    .foregroundColor(.blue)
            }
            .onTapGesture {
                withAnimation {
                    isCollapsedDescription.toggle()
                }
            }
        }
    }
}

enum FetchingError: LocalizedError {
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .unknownError:
            return "An unknown error occurred while the fetching trials."
        }
    }
}


#Preview {
    ClinicalTrialsView()
}

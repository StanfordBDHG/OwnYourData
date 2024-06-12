//
// This source file is part of the OwnYourData based on the SpeziFHIR project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import CoreLocation
import OpenAPIClient
import Spezi
import SpeziLocation


@Observable
class NCITrialsModule: Module, EnvironmentAccessible {
    @ObservationIgnored @Dependency private var locationModule: SpeziLocation
    
    private let apiKey: String
    private(set) var trials: [TrialDetail] = []
    var zipCode: String = "10025"
    var searchDistance: String = "100"
    
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    
    func fetchTrials(keywords: [String] = []) async throws {
        var coordinate: CLLocationCoordinate2D?
        
        if let userLocation = try? await locationModule.getLatestLocations().first {
            coordinate = userLocation.coordinate
            await getZipCodeFromLocation(location: userLocation)
        } else if let location = await getLocationFromZipCode(zipCode: zipCode) {
            coordinate = location.coordinate
        }
        
        trials = try await loadTrials(keywords: keywords, coordinate: coordinate).data ?? []
    }
    
    
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
    
    private func loadTrials(keywords: [String], coordinate: CLLocationCoordinate2D?, from: Int = 0) async throws -> TrialResponse {
        OpenAPIClientAPI.customHeaders = ["X-API-KEY": apiKey]
        CodableHelper.dateFormatter = NICTrialsAPIDateFormatter()
        
        let keywords = keywords.filter { !$0.isEmpty }
        
        var data: TrialResponse = try await withCheckedThrowingContinuation { continuation in
            TrialsAPI.searchTrialsByGet(
                size: 50,
                from: from,
                keyword: keywords.isEmpty ? nil : keywords,
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
        
        if from + 50 < data.total ?? 0 {
            data.data?.append(
                contentsOf: try await loadTrials(keywords: keywords, coordinate: coordinate, from: from + 50).data ?? []
            )
        }
        
        return data
    }
}

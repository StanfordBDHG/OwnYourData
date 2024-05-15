//
// This source file is part of the Stanford LLM on FHIR project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import ModelsR4
import SpeziFHIR
import SpeziFHIRMockPatients
import SwiftUI


struct ResourceSelection: View {
    @Environment(OwnYourDataStandard.self) private var standard
    @Environment(FHIRStore.self) private var store
    
    @State private var bundles: [ModelsR4.Bundle] = []
    @State private var showBundleSelection = false
    
    @MainActor var useHealthKitResources: Binding<Bool> {
        Binding(
            get: {
                if FeatureFlags.mockPatients {
                    showBundleSelection = true
                    return false
                }
                return standard.useHealthKitResources
            },
            set: { newValue in
                showBundleSelection = !newValue
                standard.useHealthKitResources = newValue
            }
        )
    }
    
    
    var body: some View {
        Form {
            Section {
                Toggle(isOn: useHealthKitResources) {
                    Text("Use HealthKit Resources")
                }
                    .onChange(of: useHealthKitResources.wrappedValue, initial: true) {
                        if useHealthKitResources.wrappedValue {
                            _Concurrency.Task {
                                await standard.loadHealthKitResources()
                            }
                        } else {
                            guard let firstMockPatient = bundles.first else {
                                return
                            }
                            
                            store.removeAllResources()
                            store.load(bundle: firstMockPatient)
                        }
                    }
            }
            if showBundleSelection {
                Section {
                    if bundles.isEmpty {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    } else {
                        FHIRBundleSelector(bundles: bundles)
                            .pickerStyle(.inline)
                    }
                }
            }
        }
            .task {
                self.bundles = await mockPatients
            }
            .onAppear {
                showBundleSelection = !standard.useHealthKitResources
            }
            .navigationTitle(Text("Resource Settings"))
    }
    
    private var mockPatients: [ModelsR4.Bundle] {
        get async {
            await [
                .breastCancerExample
            ]
        }
    }
}


extension ModelsR4.Bundle {
    private static var _breastCancerExample: ModelsR4.Bundle?
    /// Example FHIR resources packed into a bundle to represent the simulated patient named Jamison785 Denesik803.
    public static var breastCancerExample: ModelsR4.Bundle {
        get async {
            if let breastCancerExample = _breastCancerExample {
                return breastCancerExample
            }
            
            let breastCancerExample = await Foundation.Bundle.main.improvedLoadFHIRBundle(
                withName: "BreastCancerExample"
            )
            ModelsR4.Bundle._breastCancerExample = breastCancerExample
            return breastCancerExample
        }
    }
}


extension Foundation.Bundle {
    /// Loads a FHIR `Bundle` from a Foundation `Bundle`.
    /// - Parameter name: Name of the JSON file in the Foundation `Bundle`
    /// - Returns: The FHIR `Bundle`
    public func improvedLoadFHIRBundle(withName name: String) async -> ModelsR4.Bundle {
        guard let resourceURL = self.url(forResource: name, withExtension: "json") else {
            fatalError("Could not find the resource \"\(name)\".json in the SpeziFHIRMockPatients Resources folder.")
        }
        
        let loadingTask = _Concurrency.Task {
            let resourceData = try Data(contentsOf: resourceURL)
            return try JSONDecoder().decode(Bundle.self, from: resourceData)
        }
        
        do {
            return try await loadingTask.value
        } catch {
            fatalError("Could not decode the FHIR bundle named \"\(name).json\": \(error)")
        }
    }
}

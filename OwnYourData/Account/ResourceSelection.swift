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
                .allen322Ferry570,
                .beatris270Bogan287,
                .edythe31Morar593,
                .gonzalo160Duenas839,
                .jacklyn830Veum823,
                .milton509Ortiz186
            ]
        }
    }
}

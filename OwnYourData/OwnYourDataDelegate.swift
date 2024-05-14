//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Spezi
import SpeziAccount
import SpeziFHIR
import SpeziFHIRLLM
import SpeziFirebaseAccount
import SpeziFirebaseStorage
import SpeziFirestore
import SpeziHealthKit
import SpeziLLM
import SpeziLLMOpenAI
import SpeziLocation
import SpeziOnboarding
import SwiftUI


// See https://swiftpackageindex.com/stanfordspezi/spezi/documentation/spezi/speziappdelegate
class OwnYourDataDelegate: SpeziAppDelegate {
    // See https://swiftpackageindex.com/stanfordspezi/spezi/documentation/spezi/speziappdelegate/configuration
    override var configuration: Configuration {
        Configuration(standard: OwnYourDataStandard()) {
            if !FeatureFlags.disableFirebase {
                // See https://swiftpackageindex.com/stanfordspezi/speziaccount/documentation/speziaccount/initial-setup
                AccountConfiguration(configuration: [
                    .requires(\.userId),
                    .requires(\.name),
                    .collects(\.genderIdentity),
                    .collects(\.dateOfBirth)
                ])

                // See https://swiftpackageindex.com/stanfordspezi/spezifirebase/documentation/spezifirebaseaccount/firebaseaccountconfiguration
                if FeatureFlags.useFirebaseEmulator {
                    FirebaseAccountConfiguration(
                        authenticationMethods: [.emailAndPassword, .signInWithApple],
                        emulatorSettings: (host: "localhost", port: 9099)
                    )
                } else {
                    FirebaseAccountConfiguration(authenticationMethods: [.emailAndPassword, .signInWithApple])
                }
                firestore
                // See https://swiftpackageindex.com/StanfordSpezi/SpeziFirebase/documentation/spezifirebasestorage
                if FeatureFlags.useFirebaseEmulator {
                    FirebaseStorageConfiguration(emulatorSettings: (host: "localhost", port: 9199))
                } else {
                    FirebaseStorageConfiguration()
                }
            }

            if HKHealthStore.isHealthDataAvailable() {
                healthKit
            }
            
            // See https://swiftpackageindex.com/stanfordspezi/spezionboarding/documentation/spezionboarding/onboardingdatasource
            OnboardingDataSource()
            
            // See https://swiftpackageindex.com/StanfordSpezi/SpeziLLM/documentation/spezillm
            LLMRunner {
                LLMOpenAIPlatform(configuration: .init(concurrentStreams: 20))
            }
            FHIRInterpretationModule()
            
            DocumentManager()
            
            SpeziLocation()
        }
    }
    
    // See https://swiftpackageindex.com/StanfordSpezi/SpeziFirebase/documentation/spezifirestore
    private var firestore: Firestore {
        let settings = FirestoreSettings()
        if FeatureFlags.useFirebaseEmulator {
            settings.host = "localhost:8080"
            settings.cacheSettings = MemoryCacheSettings()
            settings.isSSLEnabled = false
        }
        
        return Firestore(
            settings: settings
        )
    }
    
    // See https://swiftpackageindex.com/StanfordSpezi/SpeziHealthKit/documentation/spezihealthkit
    private var healthKit: HealthKit {
        HealthKit {
            CollectSamples(
                [
                    HKClinicalType(.allergyRecord),
                    HKClinicalType(.clinicalNoteRecord),
                    HKClinicalType(.conditionRecord),
                    HKClinicalType(.coverageRecord),
                    HKClinicalType(.immunizationRecord),
                    HKClinicalType(.labResultRecord),
                    HKClinicalType(.medicationRecord),
                    HKClinicalType(.procedureRecord),
                    HKClinicalType(.vitalSignRecord)
                ],
                predicate: HKQuery.predicateForSamples(
                    withStart: Date.distantPast,
                    end: nil,
                    options: .strictEndDate
                ),
                deliverySetting: .anchorQuery(saveAnchor: false)
            )
        }
    }
}

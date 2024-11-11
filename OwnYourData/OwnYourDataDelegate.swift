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
        // swiftlint:disable:next closure_body_length
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
                LLMOpenAIPlatform(configuration: .init(concurrentStreams: 20, apiToken: self.openAIToken))
            }
            FHIRInterpretationModule(
                summaryLLMSchema: LLMOpenAISchema(
                    parameters: .init(
                        modelType: .gpt4_o,
                        systemPrompts: []
                    )
                ),
                interpretationLLMSchema: LLMOpenAISchema(
                    parameters: .init(
                        modelType: .gpt4_o,
                        systemPrompts: []
                    )
                ),
                multipleResourceInterpretationOpenAIModel: .gpt4_o,
                resourceCountLimit: 250,
                allowedResourcesFunctionCallIdentifiers: nil
            )

            DocumentManager()
            
            SpeziLocation()
            
            MatchingModule()
            
            NCITrialsModule(apiKey: self.nciAPIToken)
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
    
    nonisolated private var plist: [String: Any] {
        guard let url = Bundle.main.url(forResource: "GoogleService-Info", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let plist = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] else {
            return [:]
        }
        
        return plist
    }
    
    nonisolated private var openAIToken: String? {
        plist["OPENAI_KEY"] as? String
    }
    
    nonisolated private var nciAPIToken: String {
        guard let nciAPIToken = plist["NCI_API_KEY"] as? String else {
            fatalError("Please provide a valid NCI API key in the GoogleService-Info.plist")
        }
        
        return nciAPIToken
    }
}

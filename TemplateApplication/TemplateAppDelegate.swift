//
// This source file is part of the Stanford OwnYourData Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Spezi
import FirebaseAccount
import class FirebaseFirestore.FirestoreSettings
import FirebaseAuth
import FirestoreDataStorage
import HealthKit
import HealthKitDataSource
import SwiftUI


class TemplateAppDelegate: SpeziAppDelegate {
    override var configuration: Configuration {
        Configuration(standard: OwnYourDateStandard()) {
            if !FeatureFlags.disableFirebase {
                if FeatureFlags.useFirebaseEmulator {
                    FirebaseAccountConfiguration(emulatorSettings: (host: "localhost", port: 9099))
                } else {
                    FirebaseAccountConfiguration()
                }
                firestore
            }
            FirebaseAccountConfiguration()
        }
    }
    
    
    private var firestore: Firestore {
        let settings = FirestoreSettings()
        if FeatureFlags.useFirebaseEmulator {
            settings.host = "localhost:8080"
            settings.isPersistenceEnabled = false
            settings.isSSLEnabled = false
        }
        
        return Firestore(
            settings: settings
        )
    }
}

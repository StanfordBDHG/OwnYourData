//
// This source file is part of the Stanford OwnYourData Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Spezi
import SpeziAccount
import class FirebaseFirestore.FirestoreSettings
import FirebaseAuth
import HealthKit
import SpeziFirebaseAccount
import SpeziFirestore
import SpeziHealthKit
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
        var settings = FirestoreSettings()
        if FeatureFlags.useFirebaseEmulator {
            settings = .emulator
        }
        
        return Firestore(
            settings: settings
        )
    }
}

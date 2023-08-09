//
// This source file is part of the Stanford OwnYourData Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import HealthKit
import Spezi
import SpeziHealthKit


actor OwnYourDateStandard: Standard, HealthKitConstraint {
    func add(_ response: HKSample) async {
        print(response)
    }
    
    func remove(removalContext: SpeziHealthKit.HKSampleRemovalContext) {
        print(removalContext)
    }
}

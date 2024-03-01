//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SpeziFHIR


extension FHIRStore {
    var isEmpty: Bool {
        llmRelevantResources.isEmpty
    }
}

//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Foundation
import SpeziViews


enum MatchingState: OperationState {
    case idle
    case fhirInspection
    case nciLoading
    case matching
    case error(LocalizedError)
    
    
    var representation: ViewState {
        switch self {
        case .idle:
            .idle
        case .fhirInspection, .nciLoading, .matching:
            .processing
        case .error(let error):
            .error(error)
        }
    }
}

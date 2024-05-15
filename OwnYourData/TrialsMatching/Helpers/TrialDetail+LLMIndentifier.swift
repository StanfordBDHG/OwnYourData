//
// This source file is part of the OwnYourData based on the SpeziFHIR project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Foundation
import OpenAPIClient


extension TrialDetail {
    var llmIdentifier: String? {
        briefTitle?.components(separatedBy: CharacterSet.alphanumerics.inverted).joined()
    }
}

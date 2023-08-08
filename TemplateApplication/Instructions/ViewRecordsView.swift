//
// This source file is part of the Stanford OwnYourData Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


struct ViewRecordsView: View {
    @Environment(\.openURL) var openURL
    
    
    var body: some View {
        HowItWorks(
            steps: [
                InstructionsStep.openHealthApp,
                InstructionsStep.browseTab,
                InstructionsStep(title: "Select the records you would like to view!")
            ]
        )
    }
}


struct ViewRecordsView_Previews: PreviewProvider {
    static var previews: some View {
        RecordInstructView()
    }
}

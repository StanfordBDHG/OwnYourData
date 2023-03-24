//
// This source file is part of the Stanford CardinalKit Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import CardinalKit
import FHIR
import HealthKitDataSource
import HealthKitToFHIRAdapter
import ImageSource
import SwiftUI
import UIKit


struct RecordInstructView: View {
    @Environment(\.openURL) var openURL
    
    
    var body: some View {
        HowItWorks(
            steps: [
                InstructionsStep.openHealthApp,
                InstructionsStep.browseTab,
                InstructionsStep(title: "Scroll and select Health Records to share"),
                InstructionsStep(title: "Tap \"Export PDF\" on the top right to share PDF") {
                    Image("ExportIconImage")
                        .resizable()
                        .scaledToFit()
                        .accessibilityLabel(Text("Export an health record in the Apple Health App"))
                        .foregroundColor(Color.accentColor)
                        .frame(width: 90, height: 90)
                        .padding(.trailing, 10)
                }
            ]
        )
    }
}
struct RecordInstructView_Previews: PreviewProvider {
    static var previews: some View {
        RecordInstructView()
    }
}

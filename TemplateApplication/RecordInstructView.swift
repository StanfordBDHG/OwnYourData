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
    @State var capturedImage: ImageState = .empty
    @State var showingPicker = false
    
    
    var body: some View {
        VStack {
            LogoView()
            Spacer()
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}


struct RecordInstructView_Previews: PreviewProvider {
    static var previews: some View {
        RecordInstructView()
    }
}

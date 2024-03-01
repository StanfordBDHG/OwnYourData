//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import FirebaseAuth
import FirebaseFirestore
import SpeziFHIR
import SwiftUI


struct ShareFHIRButton: View {
    @Environment(FHIRStore.self) var fhirStore
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            ShareLink(
                item: fhirStore.exportPackage,
                preview: SharePreview(
                    Text("FHIR JSON Export Package")
                )
            ) {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                        .accessibilityHidden(true)
                    Text("Export")
                }
            }
                .buttonStyle(.borderedProminent)
            Text("Export your health records to share them with the OwnYourData team.")
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.accentColor)
                .font(.caption)
        }
            .padding()
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ShareFHIRButton()
    }
}

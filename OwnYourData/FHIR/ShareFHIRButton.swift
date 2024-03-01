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


struct ShareFHIRSection: View {
    @Environment(FHIRStore.self) var fhirStore
    
    
    var body: some View {
        Section(
            content: {
                ShareLink(
                    item: fhirStore.exportPackage,
                    preview: SharePreview(
                        Text("FHIR JSON Export Package")
                    )
                ) {
                    HStack {
                        Spacer()
                        Image(systemName: "square.and.arrow.up")
                            .accessibilityHidden(true)
                        Text("Export")
                        Spacer()
                    }
                }
            },
            header: {
                Text("Share FHIR Resources")
            },
            footer: {
                Text("Export your health records to share them with the OwnYourData team.")
            }
        )
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ShareFHIRSection()
    }
}

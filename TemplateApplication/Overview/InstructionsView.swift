//
// This source file is part of the Stanford OwnYourData Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


struct InstructionsView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "doc.text.magnifyingglass")
                .font(.system(size: 90))
                .foregroundColor(.accentColor)
                .padding(.vertical, 8)
            Text("FHIR_RESOURCES_VIEW_NO_RESOURCES")
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.leading)
        }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color(UIColor.systemGroupedBackground))
                    .shadow(radius: 5)
            )
            .padding()
    }
}

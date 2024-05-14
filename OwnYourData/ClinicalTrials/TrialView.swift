//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import OpenAPIClient
import SwiftUI


struct TrialView: View {
    let trial: TrialDetail
    @State var isExpanded = false
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(trial.briefTitle ?? "No Title")
                .bold()
            Text(trial.id ?? "No NCI ID")
                .bold()
                .foregroundStyle(.secondary)
            DisclosureGroup(isExpanded: $isExpanded) {
                Text(trial.detailDescription ?? "-")
                    .font(.caption)
            } label: {
                Text("Details")
                    .foregroundColor(.blue)
            }
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
        }
    }
}

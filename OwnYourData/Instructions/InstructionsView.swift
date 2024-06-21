//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


struct InstructionsView: View {
    @State var displayInstructions = false
    
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "doc.text.magnifyingglass")
                .accessibilityHidden(true)
                .font(.system(size: 90))
                .foregroundColor(.accentColor)
                .padding(.vertical, 8)
            Text("FHIR_RESOURCES_VIEW_NO_RESOURCES")
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.leading)
            //Text("Learn More ...")
            //    .foregroundColor(.accentColor)
        }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color(UIColor.systemGroupedBackground))
                    .shadow(radius: 5)
            )
            .padding()
            //.contentShape(Rectangle())
            //.onTapGesture {
            //    displayInstructions.toggle()
            //}
            //.sheet(isPresented: $displayInstructions) {
            //    AddRecordInstructView()
            //}
    }
}

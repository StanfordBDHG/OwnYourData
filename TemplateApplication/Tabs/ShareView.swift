//
// This source file is part of the Stanford CardinalKit Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


struct ShareView: View {
    @Environment(\.openURL) var openURL
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                LogoView()
                Spacer()
                OwnYourDataSection(
                    title: "Share \nHealth Records",
                    buttonTitle: "Open Health App",
                    destination: RecordInstructView()
                )
                OwnYourDataSection(
                    title: "Share \nDocuments",
                    buttonTitle: "Scanned Documents",
                    destination: DocumentGallery()
                )
                    }
            }
                .padding(.bottom, 30)
        }
    }


struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        AddDataView()
    }
}

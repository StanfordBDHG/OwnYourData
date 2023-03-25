//
// This source file is part of the Stanford CardinalKit Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


struct AddDataView: View {
    @State private var showDocumentScanner = false
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                LogoView()
                Spacer()
                OwnYourDataSection(
                    title: "Connect to \nHealth System",
                    buttonTitle: "Select Health System",
                    destination: AddRecordInstructView()
                )
                OwnYourDataSection(
                    title: "Take a Photo \nof Document",
                    buttonTitle: "Go to Camera",
                    action: {
                        self.showDocumentScanner.toggle()
                    }
                )
            }
                .padding(.bottom, 30)
                .fullScreenCover(isPresented: $showDocumentScanner) {
                    DocumentScanner()
                        .background {
                            Color.black.ignoresSafeArea()
                        }
                }
        }
    }
}


struct AddDataView_Previews: PreviewProvider {
    static var previews: some View {
        AddDataView()
    }
}

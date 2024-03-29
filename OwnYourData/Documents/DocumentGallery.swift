//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import PDFKit
import SwiftUI


struct DocumentGallery: View {
    @Environment(DocumentManager.self) var documentManager
    @State var documentScanner = false
    
    
    var body: some View {
        Group {
            if documentManager.documents.isEmpty {
                Text("No Documents")
            } else {
                List(documentManager.documents, id: \.documentURL) { document in
                    PDFListRow(document: document)
                }
            }
        }
            .toolbar {
                ToolbarItem {
                    Button(
                        action: {
                            documentScanner = true
                        },
                        label: {
                            Image(systemName: "plus")
                                .accessibilityLabel("Add Document")
                        }
                    )
                }
            }
            .fullScreenCover(isPresented: $documentScanner) {
                DocumentScanner()
                    .background {
                        Color.black.ignoresSafeArea()
                    }
            }
            .navigationTitle("Documents")
    }
}

struct DocumentGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentGallery()
    }
}

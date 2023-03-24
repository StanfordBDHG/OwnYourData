//
// This source file is part of the Stanford CardinalKit Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import PDFKit
import SwiftUI


struct DocumentGalleryView: View {
    @EnvironmentObject var documentManager: DocumentManager
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
        DocumentGalleryView()
    }
}

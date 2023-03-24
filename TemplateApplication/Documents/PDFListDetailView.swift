//
// This source file is part of the Stanford CardinalKit Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import PDFKit
import SwiftUI


struct PDFListDetailView: View {
    let document: PDFDocument
    
    var body: some View {
        PDFView(document)
            .toolbar {
                ToolbarItem {
                    ShareLink(item: document, preview: SharePreview("PDF"))
                }
            }
    }
}

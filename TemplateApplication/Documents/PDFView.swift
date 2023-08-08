//
// This source file is part of the Stanford OwnYourData Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import PDFKit
import SwiftUI


struct PDFView: UIViewRepresentable {
    let document: PDFDocument

    
    init(_ document: PDFDocument) {
        self.document = document
    }

    
    func makeUIView(context: Context) -> PDFKit.PDFView {
        let pdfView = PDFKit.PDFView()
        pdfView.document = document
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFKit.PDFView, context: Context) { }
}

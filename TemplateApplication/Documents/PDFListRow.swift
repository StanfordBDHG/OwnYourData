//
// This source file is part of the Stanford CardinalKit Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import PDFKit
import SwiftUI


struct PDFListRow: View {
    let document: PDFDocument
    
    
    private var documentName: String {
        document.documentURL?.lastPathComponent ?? "Document"
    }
    
    private var documentCreationDate: Date {
        guard let documentURL = document.documentURL,
              let attributes = try? FileManager.default.attributesOfItem(atPath: documentURL.path()),
              let creationDate = attributes[.creationDate] as? Date else {
            return .now
        }
        
        return creationDate
    }
    
    var body: some View {
        NavigationLink(destination: PDFListDetailView(document: document)) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(documentName)
                        .font(.title3.bold())
                    HStack {
                        Text(documentCreationDate, style: .date)
                        Text(documentCreationDate, style: .time)
                    }
                        .font(.body)
                }
                Spacer()
                PDFView(document)
                    .frame(width: 50, height: 50)
            }
                .padding()
                .frame(height: 60)
        }
    }
}

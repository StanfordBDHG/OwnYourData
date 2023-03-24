//
// This source file is part of the Stanford CardinalKit Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import PDFKit


class DocumentManager: ObservableObject {
    var documents: [PDFDocument] = [] {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    
    init() {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let ownYourDataDirectory = documentDirectory.appending(path: "OwnYourData")

        
        var documents: [PDFDocument] = []
        do {
            let items = try FileManager.default.contentsOfDirectory(at: ownYourDataDirectory, includingPropertiesForKeys: nil)
            for item in items {
                if let document = PDFDocument(url: item) {
                    documents.append(document)
                }
            }
            self.documents = documents
        } catch {
            return
        }
    }
    
    
    func store(document: PDFDocument, title: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        try? FileManager.default.createDirectory(at: documentDirectory.appending(path: "OwnYourData"), withIntermediateDirectories: true)
        
        let documentBaseName: String
        if title.isEmpty {
            documentBaseName = "Document"
        } else {
            documentBaseName = title
        }
        
        var documentName = documentBaseName
        
        for index in 1...Int.max {
            if !FileManager.default.fileExists(atPath: documentDirectory.appending(path: "OwnYourData/\(documentName).pdf").path()) {
                break
            }
            documentName = documentBaseName + "\(index)"
        }
        
        let documentPath = documentDirectory.appending(path: "OwnYourData/\(documentName).pdf")
        
        let documentSaved = document.write(to: documentPath)
        
        print("Saved the document \(documentSaved) to \(documentPath)")
        
        if let loadedFromURLDocument = PDFDocument(url: documentPath) {
            self.documents.append(loadedFromURLDocument)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.objectWillChange.send()
            }
        }
    }
}

//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import PDFKit
import Spezi


@Observable
class DocumentManager: Module, EnvironmentAccessible {
    var documents: [PDFDocument] = []
    
    var documentURLs: [URL] {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return []
        }
        
        let ownYourDataDirectory = documentDirectory.appending(path: "OwnYourData")
        return (try? FileManager.default.contentsOfDirectory(at: ownYourDataDirectory, includingPropertiesForKeys: nil)) ?? []
    }
    
    
    init() {
        self.documents = documentURLs.compactMap { documentURL in
            PDFDocument(url: documentURL)
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
        }
    }
    
    func removeAllDocuments() {
        for documentURL in documentURLs {
            try? FileManager.default.removeItem(at: documentURL)
        }
    }
}

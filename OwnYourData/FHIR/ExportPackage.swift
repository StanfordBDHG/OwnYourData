//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import CoreTransferable
import OSLog
import SpeziFHIR


struct ExportPackage: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(
            exportedContentType: .zip,
            exporting: { document in
                try await SentTransferredFile(document.zipRepresentation)
            }
        )
    }
    
    
    let resources: [FHIRResource]
    
    private var directory: URL {
        FileManager.default.temporaryDirectory.appendingPathComponent(
            "edu.stanford.ownyourdate.export",
            isDirectory: true
        )
    }
    
    var zipRepresentation: URL {
        get async throws {
            if directory.exists {
                try FileManager.default.removeItem(at: directory)
            }
            try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
            
            for resource in resources {
                let resourceJSONData = Data(resource.jsonDescription.utf8)
                try resourceJSONData.write(to: directory.appending(path: "\(resource.id).json"))
            }
            
            let zipURL = try directory.zip()
            try FileManager.default.removeItem(at: directory)
            
            return zipURL
        }
    }
    
    
    func deleteZipRepresentation() throws {
        try FileManager.default.removeItem(at: directory.appendingPathExtension(".zip"))
    }
}

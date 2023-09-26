//
// This source file is part of the Stanford OwnYourData Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Foundation
import OSLog


extension URL {
    var isDirectory: Bool {
       (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
    }
    
    var exists: Bool {
        FileManager.default.fileExists(atPath: path)
    }
    
    
    func zip(to zipURL: URL? = nil) throws -> URL {
        let logger = Logger(subsystem: "edu.stanford.spezi.zipcomponent", category: "ZipComponent")
        
        let zipURL = zipURL ?? self.appendingPathExtension("zip")
        
        let directory: URL
        let temporaryDirectory: Bool
        if isFileURL, exists, isDirectory {
            directory = self
            temporaryDirectory = false
        } else {
            // Crete a temporary folder
            directory = FileManager.default.temporaryDirectory.appendingPathComponent(
                "edu.stanford.spezi.zipcomponent/\(UUID().uuidString)",
                isDirectory: true
            )
            try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
            temporaryDirectory = true
            
            // Copy the file to the new folder
            let filePath = directory.appendingPathComponent(lastPathComponent)
            try FileManager.default.copyItem(at: self, to: filePath)
        }
        
        // Clean up the folder at the end of the function independent of the outcome
        defer {
            if temporaryDirectory {
                do {
                    try FileManager.default.removeItem(at: directory)
                } catch {
                    logger.error("Could not remove temporary directory at \(directory)")
                }
            }
        }
        
        var zipError, copyError: NSError?
        
        NSFileCoordinator().coordinate(
            readingItemAt: directory,
            options: .forUploading,
            error: &zipError
        ) { zippedURL in
            do {
                if zipURL.exists {
                    try FileManager.default.removeItem(at: zipURL)
                }
                try FileManager.default.copyItem(at: zippedURL, to: zipURL)
            } catch {
                logger.debug("Copying the ziped file from \(zippedURL) to \(zipURL) failed.")
                copyError = error as NSError
            }
        }
        
        if let copyError {
            throw copyError
        }
        if let zipError {
            logger.debug("Could not zip the directory at \(directory): \(zipError)")
            throw zipError
        }
        
        return zipURL
    }
}


extension Data {
    var zip: Data {
        get throws {
            let temporaryDirectory = FileManager.default.temporaryDirectory.appendingPathComponent(
                "edu.stanford.spezi.zipcomponent/\(UUID().uuidString)",
                isDirectory: true
            )
            
            try self.write(to: temporaryDirectory, options: .atomic)
            let zipURL = try temporaryDirectory.zip()
            
            let zippedData = try Data(contentsOf: zipURL)
            
            try? FileManager.default.removeItem(at: temporaryDirectory)
            try? FileManager.default.removeItem(at: zipURL)
            
            return zippedData
        }
    }
}

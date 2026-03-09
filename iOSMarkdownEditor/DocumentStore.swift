//
//  DocumentStore.swift
//  iOSMarkdownEditor
//
//  Created by 李卓非 on 9/3/2026.
//

import Foundation

enum DocumentStore {
    private static let fileName = "documents.json"

    private static var fileURL: URL {
        let documentsDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first!

        return documentsDirectory.appendingPathComponent(fileName)
    }

    static func loadDocuments() -> [MarkdownDocument] {
        do {
            let data = try Data(contentsOf: fileURL)
            let documents = try JSONDecoder().decode([MarkdownDocument].self, from: data)
            return documents
        } catch {
            return []
        }
    }

    static func saveDocuments(_ documents: [MarkdownDocument]) {
        do {
            let data = try JSONEncoder().encode(documents)
            try data.write(to: fileURL, options: [.atomic])
        } catch {
            print("Failed to save documents: \(error)")
        }
    }
}

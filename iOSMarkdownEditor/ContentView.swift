//
//  ContentView.swift
//  iOSMarkdownEditor
//
//  Created by 李卓非 on 9/3/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var documents: [MarkdownDocument] = []

    private var sortedDocuments: [MarkdownDocument] {
        documents.sorted { $0.updatedAt > $1.updatedAt }
    }

    var body: some View {
        NavigationStack {
            List {
                Section("Documents") {
                    ForEach(sortedDocuments) { document in
                        if let index = documents.firstIndex(where: { $0.id == document.id }) {
                            NavigationLink(destination: EditorView(document: $documents[index])) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(documents[index].title.isEmpty ? "Untitled" : documents[index].title)
                                        .font(.body)

                                    Text(documents[index].updatedAt, style: .date)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteDocumentFromSortedList)
                }
            }
            .navigationTitle("Markdown Documents")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        createDocument()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .onAppear {
            loadDocuments()
        }
        .onChange(of: documents) { _, newValue in
            DocumentStore.saveDocuments(newValue)
        }
    }

    private func loadDocuments() {
        let savedDocuments = DocumentStore.loadDocuments()

        if savedDocuments.isEmpty {
            documents = [
                MarkdownDocument(
                    id: UUID(),
                    title: "Welcome.md",
                    content: "# Welcome",
                    createdAt: Date(),
                    updatedAt: Date()
                ),
                MarkdownDocument(
                    id: UUID(),
                    title: "Notes.md",
                    content: "## Notes",
                    createdAt: Date(),
                    updatedAt: Date()
                ),
                MarkdownDocument(
                    id: UUID(),
                    title: "Draft.md",
                    content: "Draft content",
                    createdAt: Date(),
                    updatedAt: Date()
                )
            ]
        } else {
            documents = savedDocuments
        }
    }

    private func createDocument() {
        let newDocument = MarkdownDocument(
            id: UUID(),
            title: "Untitled-\(documents.count + 1)",
            content: "",
            createdAt: Date(),
            updatedAt: Date()
        )
        documents.append(newDocument)
    }

    private func deleteDocumentFromSortedList(at offsets: IndexSet) {
        let documentsToDelete = offsets.map { sortedDocuments[$0].id }
        documents.removeAll { documentsToDelete.contains($0.id) }
    }
}

#Preview {
    ContentView()
}

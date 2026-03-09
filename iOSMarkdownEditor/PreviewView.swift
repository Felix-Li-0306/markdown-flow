//
//  PreviewView.swift
//  iOSMarkdownEditor
//
//  Created by 李卓非 on 9/3/2026.
//

import SwiftUI

struct PreviewView: View {
    let title: String
    let content: String

    private var displayTitle: String {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? "Untitled" : trimmed
    }

    var body: some View {
        MarkdownWebView(
            html: MarkdownRenderer.makeHTML(title: displayTitle, markdown: content)
        )
        .navigationTitle("Preview")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    PreviewView(
        title: "Welcome",
        content: """
        # Welcome

        This is **bold** text, and this is *italic* text.

        Inline math: $E=mc^2$

        $$\\int_0^1 x^2 \\, dx = \\frac{1}{3}$$
        """
    )
}

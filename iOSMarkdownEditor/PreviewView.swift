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

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)

                Text("Rendered Preview")
                    .font(.headline)

                Text(content)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding()
        }
        .navigationTitle("Preview")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    PreviewView(
        title: "Welcome.md",
        content: "# Welcome\n\nThis is a preview."
    )
}

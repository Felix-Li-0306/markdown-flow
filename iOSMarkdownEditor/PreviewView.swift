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

    private var htmlContent: String {
        """
        <!DOCTYPE html>
        <html>
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>
                body {
                    font-family: -apple-system, BlinkMacSystemFont, sans-serif;
                    padding: 16px;
                    line-height: 1.6;
                    font-size: 17px;
                    color: #111;
                    background-color: #ffffff;
                    word-wrap: break-word;
                }
                h1, h2, h3 {
                    line-height: 1.25;
                }
                pre {
                    background: #f4f4f4;
                    padding: 12px;
                    border-radius: 10px;
                    overflow-x: auto;
                }
                code {
                    background: #f4f4f4;
                    padding: 2px 6px;
                    border-radius: 6px;
                }
            </style>
        </head>
        <body>
            <h2>\(title)</h2>
            <pre>\(escapeHTML(content))</pre>
        </body>
        </html>
        """
    }

    var body: some View {
        MarkdownWebView(html: htmlContent)
            .navigationTitle("Preview")
            .navigationBarTitleDisplayMode(.inline)
    }

    private func escapeHTML(_ text: String) -> String {
        text
            .replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
    }
}

#Preview {
    PreviewView(
        title: "Welcome.md",
        content: "# Welcome\n\nThis is a preview.\n\n$E=mc^2$"
    )
}

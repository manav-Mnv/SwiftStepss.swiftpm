import SwiftUI

// MARK: - CodeEditorView

struct CodeEditorView: View {
    @Binding var code: String
    var isDisabled: Bool = false

    private let lineNumberWidth: CGFloat = 36
    private let editorBorderWidth: CGFloat = 4

    var body: some View {
        VStack(spacing: 0) {
            // Header bar
            editorHeader

            // Editor body
            ZStack(alignment: .topLeading) {
                // Background
                Theme.editorBackground
                    .ignoresSafeArea(edges: [])

                HStack(alignment: .top, spacing: 0) {
                    // Line numbers
                    lineNumbers
                        .frame(width: lineNumberWidth)

                    // Separator
                    Rectangle()
                        .fill(Color.white.opacity(0.08))
                        .frame(width: 1)

                    // Code area
                    codeTextEditor
                }
            }
        }
        .background(
            PixelFrame(
                baseColor: Theme.editorBackground,
                borderColor: Theme.pixelOrange.opacity(0.4),
                shadowColor: Theme.pixelShadow,
                borderWidth: editorBorderWidth
            )
        )
        .frame(minHeight: 180, maxHeight: 280)
    }

    // MARK: - Header

    private var editorHeader: some View {
        HStack(spacing: Theme.Spacing.xs) {
            // Fake terminal dots
            Circle()
                .fill(Theme.pixelRed.opacity(0.8))
                .frame(width: 8, height: 8)
            Circle()
                .fill(Theme.pixelYellow.opacity(0.8))
                .frame(width: 8, height: 8)
            Circle()
                .fill(Theme.pixelGreen.opacity(0.8))
                .frame(width: 8, height: 8)

            Spacer()

            Text("main.swift")
                .font(Theme.pixelFont(size: 9))
                .foregroundColor(Color.white.opacity(0.4))
        }
        .padding(.horizontal, Theme.Spacing.sm)
        .padding(.vertical, 6)
        .background(Color.white.opacity(0.03))
    }

    // MARK: - Line Numbers

    private var lineNumbers: some View {
        let lines = code.components(separatedBy: "\n")
        return VStack(alignment: .trailing, spacing: 0) {
            ForEach(0..<max(lines.count, 1), id: \.self) { i in
                Text("\(i + 1)")
                    .font(.system(size: 13, weight: .regular, design: .monospaced))
                    .foregroundColor(Color.white.opacity(0.2))
                    .frame(height: 20)
            }
            Spacer()
        }
        .padding(.top, 10)
        .padding(.trailing, 6)
    }

    // MARK: - Code Text Editor

    private var codeTextEditor: some View {
        TextEditor(text: $code)
            .font(.system(size: 14, weight: .regular, design: .monospaced))
            .foregroundColor(Color.white.opacity(0.9))
            .scrollContentBackground(.hidden)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .disabled(isDisabled)
            .padding(.horizontal, Theme.Spacing.xs)
            .padding(.vertical, 6)
    }
}

#Preview {
    ZStack {
        Theme.deepNavy.ignoresSafeArea()
        CodeEditorView(code: .constant("print(\"Hello Swift\")\n\nlet x = 10"))
            .padding()
    }
}

import SwiftUI

// MARK: - PixelButton

struct PixelButton: View {

    let title: String
    var action: () -> Void = {}

    @State private var isPressed = false
    @State private var idleOffset: CGFloat = 0

    var body: some View {
        Text(title)
            .font(Theme.pixelFont(size: 20))
            .foregroundStyle(Theme.deepNavy)
            .padding(.horizontal, Theme.Spacing.xl)
            .padding(.vertical, Theme.Spacing.md)
            .background(
                PixelFrame(
                    baseColor: Theme.pixelYellow,
                    borderColor: Theme.deepNavy,
                    shadowColor: isPressed ? nil : Theme.pixelShadow,
                    borderWidth: 4
                )
                .offset(y: isPressed ? 4 : 0)
            )
            .scaleEffect(isPressed ? 0.98 : 1.0)
            .animation(.easeInOut(duration: 0.05), value: isPressed)
            // Idle float
            .onAppear {
                withAnimation(
                    .easeInOut(duration: 2.5)
                    .repeatForever(autoreverses: true)
                ) {
                    idleOffset = -3
                }
            }
            // Press gesture
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !isPressed {
                            isPressed = true
                            triggerHaptic()
                        }
                    }
                    .onEnded { _ in
                        isPressed = false
                        action()
                    }
            )
    }

    // MARK: Haptic

    private func triggerHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

#Preview {
    ZStack {
        Theme.deepNavy.ignoresSafeArea()
        PixelButton(title: "Get Started")
    }
}

import SwiftUI

struct RetroMonitorOverlay: View {
    var body: some View {
        ZStack {
            // 1. CRT Scanlines
            GeometryReader { geo in
                Path { path in
                    let spacing: CGFloat = 4
                    for y in stride(from: 0, to: geo.size.height, by: spacing) {
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: geo.size.width, y: y))
                    }
                }
                .stroke(Color.black.opacity(0.15), lineWidth: 1)
            }
            .allowsHitTesting(false)
            
            // 2. Screen Grille / Pixelex Texture
            Rectangle()
                .fill(
                    ImagePaint(
                        image: Image(systemName: "square.fill"),
                        sourceRect: CGRect(x: 0, y: 0, width: 1, height: 1),
                        scale: 0.1
                    )
                )
                .opacity(0.02)
                .allowsHitTesting(false)
            
            // 3. Vignette (Tube Curve)
            RadialGradient(
                gradient: Gradient(colors: [.clear, .black.opacity(0.4)]),
                center: .center,
                startRadius: 200,
                endRadius: 600
            )
            .allowsHitTesting(false)
            
            // 4. Slight Glow / Tint
            Color.blue.opacity(0.02)
                .allowsHitTesting(false)
        }
        .ignoresSafeArea()
    }
}

// Extension to easily apply the monitor look
extension View {
    func retroMonitorLook() -> some View {
        ZStack {
            self
            RetroMonitorOverlay()
        }
    }
}

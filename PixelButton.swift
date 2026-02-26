import SwiftUI

// MARK: - Component: Pixel Button
struct PixelButton: View {
    let title: String
    let action: () -> Void
    
    @State private var isHovering = false
    
    var body: some View {
        Button(action: action) {
            Text(title.uppercased())
                .font(.system(size: 20, weight: .black, design: .monospaced))
                .padding(.vertical, 16)
                .padding(.horizontal, 24)
        }
        .buttonStyle(Phase4PixelButtonStyle(isHovering: isHovering))
        // Hover state handled outside the ButtonStyle for architectural safety
        .onHover { hovering in
            isHovering = hovering
        }
    }
}

// MARK: - Internal: Style Logic
struct Phase4PixelButtonStyle: ButtonStyle {
    let isHovering: Bool
    
    // We use the Theme colors already available
    let mainColor = Theme.pixelOrange
    let bgColor = Theme.deepNavy
    let borderColor = Color.white
    let shadowColor = Theme.pixelShadow
    let pixelSize: CGFloat = 4
    let shadowOffset: CGFloat = 6
    
    func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        
        configuration.label
            .foregroundColor(bgColor)
            // 1. The Main Face
            .background(mainColor)
            // 2. The Hard Pixel Border
            .overlay(
                Rectangle()
                    .stroke(borderColor, lineWidth: pixelSize)
            )
            // 3. The "Bloom" (Only exception to blur, used for Glow)
            // Using a simple overlay with a shadow to simulate CRT bloom
            .overlay(
                Rectangle()
                    .stroke(mainColor, lineWidth: isHovering ? 2 : 0)
                    .blur(radius: isHovering ? 8 : 0)
            )
            // 4. The Hard Shadow (The Depth)
            .background(
                Rectangle()
                    .fill(shadowColor)
                    .offset(
                        x: isPressed ? 0 : shadowOffset, 
                        y: isPressed ? 0 : shadowOffset
                    )
            )
            // 5. The "Squish" Interaction
            // Physically moves the button down-right to cover the shadow
            .offset(
                x: isPressed ? shadowOffset : 0, 
                y: isPressed ? shadowOffset : 0
            )
            // 6. Haptic Feedback (via onChange since buttonStyle can't use onTouch easily without dragging state)
            .onChange(of: isPressed) { newValue in
                if newValue {
                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                    generator.impactOccurred()
                }
            }
            .animation(.interactiveSpring(response: 0.15, dampingFraction: 0.6), value: isPressed)
    }
}

// MARK: - Preview Rig
struct PixelButton_Preview: View {
    var body: some View {
        ZStack {
            Theme.deepNavy.ignoresSafeArea()
            
            VStack(spacing: 40) {
                PixelButton(title: "Start Mission") {
                    print("Button Pressed!")
                }
                
                PixelButton(title: "Retry Level") {
                    print("Retrying...")
                }
            }
        }
    }
}

#Preview {
    PixelButton_Preview()
}

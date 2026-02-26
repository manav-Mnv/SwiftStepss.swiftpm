import SwiftUI

struct CourseCardView: View {
    let title: String
    let description: String
    let badge: String
    let accentColor: Color
    let imageName: String
    var action: (() -> Void)? = nil
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            VStack(alignment: .leading, spacing: 0) {
                // 1. Pixel image header (16:9) AspectFill, No stretching, No GeometryReader
                Color.clear
                    .aspectRatio(16/9, contentMode: .fit)
                    .overlay(
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    )
                    .background(Theme.lockedGray) // Fallback if image asset is missing
                    .clipped()
                
                VStack(alignment: .leading, spacing: 12) {
                    // 2. COURSE label
                    Text("COURSE")
                        .font(Theme.pixelFont(size: 12))
                        .foregroundColor(accentColor)
                        .tracking(2.0)
                        .textCase(.uppercase)
                    
                    // 3. Course Title
                    Text(title)
                        .font(Theme.pixelFont(size: 28)) // 26-30
                        .foregroundColor(Theme.whiteText)
                    
                    // 4. Description
                    Text(description)
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .foregroundColor(Theme.whiteText.opacity(0.8))
                        .lineLimit(2)
                        .truncationMode(.tail)
                        .frame(minHeight: 40, alignment: .topLeading)
                        .multilineTextAlignment(.leading)
                    
                    // 5. Difficulty badge
                    Text(badge)
                        .font(Theme.pixelFont(size: 10))
                        .foregroundColor(Theme.whiteText)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Theme.deepNavy)
                        .overlay(
                            Rectangle()
                                .stroke(Theme.whiteText, lineWidth: 2)
                        )
                        .padding(.top, 4)
                }
                .padding(20)
                .background(Theme.deepNavy)
            }
            // 4pt white pixel border
            .border(Color.white, width: 4)
        }
        .buttonStyle(PixelCardButtonStyle(isHovering: isHovered, accentColor: accentColor))
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.2)) {
                isHovered = hovering
            }
        }
    }
}

// MARK: - Internal: Style Logic
struct PixelCardButtonStyle: ButtonStyle {
    let isHovering: Bool
    let accentColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        
        configuration.label
            // Hard shadow must be solid color block, disappears on press
            .background(
                Rectangle()
                    .fill(Theme.pixelShadow)
                    .offset(
                        x: isPressed ? 0 : 6,
                        y: isPressed ? 0 : 6
                    )
            )
            // Soft colored glow on hover
            .shadow(
                color: isHovering ? accentColor.opacity(0.6) : .clear,
                radius: 12, x: 0, y: 0
            )
            // Physical squish interaction
            .offset(
                x: isPressed ? 4 : 0,
                y: isPressed ? 4 : 0
            )
            .scaleEffect(isPressed ? 0.97 : 1.0)
            .animation(.interactiveSpring(response: 0.15, dampingFraction: 0.6), value: isPressed)
            // Haptic Feedback
            .sensoryFeedback(.impact(weight: .heavy), trigger: isPressed) { oldValue, newValue in
                return newValue == true
            }
    }
}

import SwiftUI

struct PixelButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .offset(y: configuration.isPressed ? 6 : 0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
            .sensoryFeedback(.impact(weight: .heavy, intensity: 1.0), trigger: configuration.isPressed)
    }
}

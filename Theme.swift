import SwiftUI

// MARK: - Theme

enum Theme {

    // MARK: Colors

    static let deepNavy = Color(red: 10 / 255, green: 10 / 255, blue: 28 / 255)
    static let skyBlue = Color(red: 100 / 255, green: 180 / 255, blue: 255 / 255)
    static let pixelYellow = Color(red: 255 / 255, green: 214 / 255, blue: 51 / 255)
    static let pixelShadow = Color(red: 20 / 255, green: 20 / 255, blue: 40 / 255)
    static let whiteText = Color.white

    // MARK: Typography

    /// Primary pixel-style font. Replace body with a custom font name later.
    static func pixelFont(size: CGFloat) -> Font {
        .system(size: size, weight: .heavy, design: .monospaced)
    }

    // MARK: Spacing

    enum Spacing {
        static let xxs: CGFloat = 4
        static let xs: CGFloat = 8
        static let sm: CGFloat = 12
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 48
    }
}

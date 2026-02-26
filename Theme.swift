import SwiftUI

// MARK: - Theme

enum Theme {

    // MARK: Colors

    static let deepNavy = Color(red: 10 / 255, green: 10 / 255, blue: 28 / 255)
    static let skyBlue = Color(red: 100 / 255, green: 180 / 255, blue: 255 / 255)
    static let pixelYellow = Color(red: 255 / 255, green: 214 / 255, blue: 51 / 255)
    static let pixelShadow = Color(red: 20 / 255, green: 20 / 255, blue: 40 / 255)
    static let whiteText = Color.white
    static let pixelGreen = Color(red: 50 / 255, green: 205 / 255, blue: 100 / 255)
    static let pixelRed = Color(red: 240 / 255, green: 80 / 255, blue: 80 / 255)
    static let pixelOrange = Color(red: 240 / 255, green: 130 / 255, blue: 55 / 255)
    static let lockedGray = Color(red: 90 / 255, green: 90 / 255, blue: 110 / 255)
    static let editorBackground = Color(red: 18 / 255, green: 18 / 255, blue: 36 / 255)
    
    // Course Selection Colors
    static let swiftOrange = Color(red: 240 / 255, green: 81 / 255, blue: 56 / 255)
    static let tealBlue = Color.teal
    static let coursePurple = Color.purple
    static let lightGray = Color(red: 42 / 255, green: 42 / 255, blue: 64 / 255)
    static let categoryBlue = Color(red: 50 / 255, green: 140 / 255, blue: 255 / 255)

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

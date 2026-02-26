import SwiftUI

// MARK: - LandingView

struct LandingView: View {

    var startAction: () -> Void = {}
    @State private var birdFloat: CGFloat = 0

    var body: some View {
        GeometryReader { geo in
            let isIPad = geo.size.width > 600

            ZStack {
                // Background video
                VideoBackgroundView()
                    .ignoresSafeArea()

                // Dark overlay for readability
                Theme.deepNavy
                    .opacity(0.55)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    // ── Top Navigation Bar ──
                    navBar(isIPad: isIPad)

                    Spacer()

                    // ── Hero Content ──
                    heroContent(isIPad: isIPad)

                    Spacer()

                    // ── Primary Button ──
                    PixelButton(title: "Get Started") {
                        startAction()
                    }
                    .padding(.bottom, isIPad ? Theme.Spacing.xxl : Theme.Spacing.xl)
                }
            }
            .retroMonitorLook()
        }
    }

    // MARK: - Bird Logo

    private var birdLogo: some View {
        Group {
            if let image = loadBirdImage() {
                Image(uiImage: image)
                    .resizable()
                    .interpolation(.none)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
            } else {
                Image(systemName: "bird.fill")
                    .font(.title2)
                    .foregroundStyle(Theme.pixelYellow)
            }
        }
    }

    private func loadBirdImage() -> UIImage? {
        let url = Bundle.main.url(forResource: "bird_logo", withExtension: "jpeg")
        guard let url, let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)
    }

    // MARK: - Navigation Bar

    @ViewBuilder
    private func navBar(isIPad: Bool) -> some View {
        HStack {
            // Bird logo — left
            birdLogo
                .offset(y: birdFloat)
                .onAppear {
                    withAnimation(
                        .easeInOut(duration: 2.0)
                        .repeatForever(autoreverses: true)
                    ) {
                        birdFloat = -6
                    }
                }

            Spacer()

            // Icons — right
            HStack(spacing: Theme.Spacing.md) {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .foregroundStyle(Theme.whiteText)

                Image(systemName: "line.3.horizontal")
                    .font(.title3)
                    .foregroundStyle(Theme.whiteText)
            }
        }
        .padding(.horizontal, Theme.Spacing.lg)
        .frame(height: 80)
        .background(Theme.deepNavy)
    }

    // MARK: - Hero Content

    @ViewBuilder
    private func heroContent(isIPad: Bool) -> some View {
        VStack(spacing: Theme.Spacing.md) {
            // Small label
            Text("START YOUR")
                .font(Theme.pixelFont(size: isIPad ? 16 : 13))
                .tracking(6)
                .foregroundStyle(Theme.skyBlue)

            // Main title — stacked with pixel outline
            VStack(alignment: .leading, spacing: 0) {
                pixelText("Swift", size: isIPad ? 60 : 44)
                pixelText("Stepss", size: isIPad ? 60 : 44)
                    .padding(.leading, isIPad ? 80 : 50)
            }

            // Subtitle
            Text("The most fun and beginner-friendly way to learn to code.")
                .font(Theme.pixelFont(size: isIPad ? 17 : 14))
                .foregroundStyle(Theme.whiteText.opacity(0.8))
                .multilineTextAlignment(.center)
                .frame(maxWidth: isIPad ? 500 : .infinity)
                .padding(.horizontal, Theme.Spacing.lg)
        }
    }

    private func pixelText(_ text: String, size: CGFloat) -> some View {
        ZStack {
            // Pixelated outline (aggressive block style)
            ForEach([
                (-3, -3), (3, -3), (-3, 3), (3, 3), 
                (0, -4), (0, 4), (-4, 0), (4, 0),
                (-2, -4), (2, -4), (-2, 4), (2, 4),
                (-4, -2), (4, -2), (-4, 2), (4, 2)
            ], id: \.0) { offset in
                Text(text)
                    .font(Theme.pixelFont(size: size))
                    .foregroundStyle(Theme.deepNavy)
                    .offset(x: CGFloat(offset.0), y: CGFloat(offset.1))
            }

            // Foreground
            Text(text)
                .font(Theme.pixelFont(size: size))
                .foregroundStyle(Theme.whiteText)
        }
    }
}

#Preview {
    LandingView()
        .preferredColorScheme(.dark)
}

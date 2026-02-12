import SwiftUI
import AVKit

// MARK: - VideoBackgroundView

struct VideoBackgroundView: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {
        let containerView = PlayerContainerView(frame: .zero)
        containerView.backgroundColor = UIColor(Theme.deepNavy)

        let videoURL: URL? = Bundle.main.url(forResource: "background_video", withExtension: "mp4")

        guard let videoURL else {
            // Asset not found — show solid navy background as fallback
            return containerView
        }

        let player = AVPlayer(url: videoURL)
        player.isMuted = true
        player.actionAtItemEnd = .none

        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = containerView.bounds

        containerView.layer.addSublayer(playerLayer)
        containerView.playerLayer = playerLayer

        // Store reference for looping
        context.coordinator.player = player

        // Loop notification
        NotificationCenter.default.addObserver(
            context.coordinator,
            selector: #selector(Coordinator.playerDidFinish(_:)),
            name: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem
        )

        player.play()

        return containerView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Layout is handled by PlayerContainerView.layoutSubviews
    }

    func makeCoordinator() -> Coordinator { Coordinator() }

    // MARK: - PlayerContainerView

    /// UIView subclass that keeps the AVPlayerLayer sized correctly on layout changes.
    final class PlayerContainerView: UIView {
        var playerLayer: AVPlayerLayer?

        override func layoutSubviews() {
            super.layoutSubviews()
            playerLayer?.frame = bounds
        }
    }

    // MARK: - Coordinator

    final class Coordinator: NSObject {
        var player: AVPlayer?

        @objc func playerDidFinish(_ notification: Notification) {
            player?.seek(to: .zero)
            player?.play()
        }

        deinit {
            NotificationCenter.default.removeObserver(self)
        }
    }
}

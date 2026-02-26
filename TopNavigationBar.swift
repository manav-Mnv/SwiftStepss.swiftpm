import SwiftUI

struct TopNavigationBar: View {
    var body: some View {
        HStack {
            // Left: Pixel coin icon (local PNG asset)
            Image("coin")
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
            
            Spacer()
            
            // Center: "Learn"
            Text("LEARN")
                .font(Theme.pixelFont(size: 22))
                .foregroundColor(Theme.whiteText)
            
            Spacer()
            
            // Right: Pixel search and menu
            HStack(spacing: 16) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20, weight: .heavy))
                    .foregroundColor(Theme.whiteText)
                
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 20, weight: .heavy))
                    .foregroundColor(Theme.whiteText)
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 72)
        .background(Theme.deepNavy)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Theme.lightGray),
            alignment: .bottom
        )
    }
}

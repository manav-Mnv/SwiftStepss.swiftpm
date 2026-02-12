import SwiftUI

struct PixelFrame: View {
    let baseColor: Color
    let borderColor: Color
    var shadowColor: Color? = nil
    var borderWidth: CGFloat = 4
    
    var body: some View {
        ZStack {
            // Shadow (if provided)
            if let shadow = shadowColor {
                Rectangle()
                    .fill(shadow)
                    .offset(x: 4, y: 4)
            }
            
            // Base background
            Rectangle()
                .fill(baseColor)
            
            // Border (drawn as 4 segments to allow "notched" corners)
            GeometryReader { geo in
                let w = geo.size.width
                let h = geo.size.height
                let bw = borderWidth
                
                ZStack {
                    // Top
                    Rectangle()
                        .fill(borderColor)
                        .frame(width: w - (bw * 2), height: bw)
                        .position(x: w / 2, y: bw / 2)
                    
                    // Bottom
                    Rectangle()
                        .fill(borderColor)
                        .frame(width: w - (bw * 2), height: bw)
                        .position(x: w / 2, y: h - (bw / 2))
                    
                    // Left
                    Rectangle()
                        .fill(borderColor)
                        .frame(width: bw, height: h - (bw * 2))
                        .position(x: bw / 2, y: h / 2)
                    
                    // Right
                    Rectangle()
                        .fill(borderColor)
                        .frame(width: bw, height: h - (bw * 2))
                        .position(x: w - (bw / 2), y: h / 2)
                }
            }
        }
    }
}

#Preview {
    PixelFrame(baseColor: .yellow, borderColor: .black, shadowColor: .gray)
        .frame(width: 200, height: 60)
        .padding()
}

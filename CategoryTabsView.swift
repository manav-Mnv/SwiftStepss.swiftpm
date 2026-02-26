import SwiftUI

struct CategoryTabsView: View {
    let categories = ["Foundations", "iOS Development", "SwiftUI", "Advanced"]
    @State private var selectedCategory = "Foundations"
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(categories, id: \.self) { category in
                    let isSelected = selectedCategory == category
                    
                    Text(category)
                        .font(Theme.pixelFont(size: 16))
                        .foregroundColor(isSelected ? Theme.whiteText : Theme.lightGray)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(isSelected ? Theme.skyBlue : Theme.deepNavy)
                        .cornerRadius(4) // Chunky 4pt corner radius
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(isSelected ? Theme.tealBlue : Theme.lightGray, lineWidth: isSelected ? 3 : 1)
                        )
                        .shadow(color: isSelected ? Theme.pixelShadow : .clear, radius: 0, x: 2, y: 2) // Slight hard shadow
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                selectedCategory = category
                            }
                        }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
    }
}

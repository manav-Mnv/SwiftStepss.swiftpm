import SwiftUI

struct CourseSelectionView: View {
    var courseSelectedAction: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            // Deep Navy Background
            Theme.deepNavy.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Navigation Bar
                TopNavigationBar()
                
                // Category Filter Tabs
                CategoryTabsView()
                    .padding(.bottom, 8)
                
                // Course Scroll List
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 24) {
                        // Card 1
                        CourseCardView(
                            title: "Swift",
                            description: "Learn variables, control flow, functions, and core Swift concepts.",
                            badge: "BEGINNER",
                            accentColor: Theme.swiftOrange,
                            imageName: "swift_header_pixel",
                            action: courseSelectedAction
                        )
                        
                        // Card 2
                        CourseCardView(
                            title: "SwiftUI",
                            description: "Build beautiful iOS apps using declarative UI and animation.",
                            badge: "INTERMEDIATE",
                            accentColor: Theme.tealBlue,
                            imageName: "swiftui_header_pixel",
                            action: courseSelectedAction
                        )
                        
                        // Card 3
                        CourseCardView(
                            title: "App Architecture",
                            description: "State management, MVVM, navigation, and scalable design patterns.",
                            badge: "ADVANCED",
                            accentColor: Theme.coursePurple,
                            imageName: "architecture_header_pixel",
                            action: courseSelectedAction
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 40)
                    // The maxWidth is for iPad layout avoiding stretching awkwardness
                    .frame(maxWidth: 600)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
    }
}

#Preview {
    CourseSelectionView()
}

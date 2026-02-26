import SwiftUI

// MARK: - ContentView

struct ContentView: View {
    @StateObject private var exerciseState = ExerciseState()
    @State private var showExercise = false

    var body: some View {
        ZStack {
            if showExercise, let exercise = exerciseState.activeExercise {
                ExerciseDetailView(
                    state: exerciseState,
                    exercise: exercise,
                    onBack: {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            showExercise = false
                        }
                    },
                    onContinue: {
                        exerciseState.advanceToNextExercise()
                        // Stay on exercise screen with next exercise
                    }
                )
                .transition(.move(edge: .trailing).combined(with: .opacity))
            } else {
                CourseSelectionView(courseSelectedAction: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showExercise = true
                    }
                })
                .transition(.move(edge: .leading).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.4), value: showExercise)
        .animation(.easeInOut(duration: 0.3), value: exerciseState.activeExerciseIndex)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}


import SwiftUI

// MARK: - ExerciseState

@MainActor
final class ExerciseState: ObservableObject {

    // MARK: Published

    @Published var exercises: [ExerciseModel]
    @Published private(set) var currentXP: Int = 0
    @Published var activeExerciseIndex: Int = 0
    @Published private(set) var completedIDs: Set<UUID> = []

    // MARK: Init

    init(exercises: [ExerciseModel] = SampleExercises.chapter1()) {
        self.exercises = exercises
    }

    // MARK: Computed

    var activeExercise: ExerciseModel? {
        guard activeExerciseIndex >= 0, activeExerciseIndex < exercises.count else { return nil }
        return exercises[activeExerciseIndex]
    }

    var totalAvailableXP: Int {
        exercises.reduce(0) { $0 + $1.xpReward }
    }

    var completionPercentage: Double {
        guard !exercises.isEmpty else { return 0 }
        return Double(completedIDs.count) / Double(exercises.count)
    }

    // MARK: Unlock Logic

    func isUnlocked(_ exercise: ExerciseModel) -> Bool {
        guard let index = exercises.firstIndex(where: { $0.id == exercise.id }) else {
            return false
        }
        // First exercise is always unlocked
        if index == 0 { return true }
        // Unlocked when previous exercise is completed
        return completedIDs.contains(exercises[index - 1].id)
    }

    func isCompleted(_ exercise: ExerciseModel) -> Bool {
        completedIDs.contains(exercise.id)
    }

    // MARK: Actions

    func completeExercise(_ exercise: ExerciseModel) {
        // Prevent duplicate XP
        guard !completedIDs.contains(exercise.id) else { return }

        completedIDs.insert(exercise.id)

        // Mark completed in array
        if let index = exercises.firstIndex(where: { $0.id == exercise.id }) {
            exercises[index].isCompleted = true
        }

        // Award XP
        withAnimation(.easeOut(duration: 0.4)) {
            currentXP += exercise.xpReward
        }
    }

    func advanceToNextExercise() {
        let nextIndex = activeExerciseIndex + 1
        if nextIndex < exercises.count {
            activeExerciseIndex = nextIndex
        }
    }
}

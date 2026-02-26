import Foundation

// MARK: - ExerciseModel

struct ExerciseModel: Identifiable, Sendable {
    let id: UUID
    let title: String
    let description: String
    let starterCode: String
    let expectedPatterns: [String]
    let forbiddenPatterns: [String]
    let xpReward: Int
    var isCompleted: Bool

    init(
        id: UUID = UUID(),
        title: String,
        description: String,
        starterCode: String,
        expectedPatterns: [String],
        forbiddenPatterns: [String] = [],
        xpReward: Int,
        isCompleted: Bool = false
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.starterCode = starterCode
        self.expectedPatterns = expectedPatterns
        self.forbiddenPatterns = forbiddenPatterns
        self.xpReward = xpReward
        self.isCompleted = isCompleted
    }
}

// MARK: - Sample Exercises

enum SampleExercises {

    static func chapter1() -> [ExerciseModel] {
        [
            ExerciseModel(
                title: "Print Hello Swift",
                description: "Use print() to display \"Hello Swift\" in the console.",
                starterCode: "print()",
                expectedPatterns: ["print", "\"Hello Swift\""],
                xpReward: 10
            ),
            ExerciseModel(
                title: "Declare a Variable",
                description: "Create a variable called name and assign it your name as a String.",
                starterCode: "// Declare your variable below\n",
                expectedPatterns: ["var", "name", "="],
                forbiddenPatterns: ["let"],
                xpReward: 10
            ),
            ExerciseModel(
                title: "String Interpolation",
                description: "Use string interpolation to print \"Hello, <name>!\" using a variable.",
                starterCode: "let name = \"Swift\"\nprint()",
                expectedPatterns: ["\\(", "name", "print"],
                xpReward: 10
            ),
            ExerciseModel(
                title: "Comments",
                description: "Add a single-line comment above the print statement explaining what it does.",
                starterCode: "\nprint(\"Hello Swift\")",
                expectedPatterns: ["//", "print"],
                xpReward: 10
            ),
            ExerciseModel(
                title: "Build a Greeting Program",
                description: "Create a variable greeting, assign \"Hello, World!\" to it, and print it using string interpolation.",
                starterCode: "// Build your greeting program\n",
                expectedPatterns: ["var", "greeting", "print", "\\("],
                xpReward: 30
            )
        ]
    }
}

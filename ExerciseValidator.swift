import Foundation

// MARK: - ValidationResult

enum ValidationResult: Sendable {
    case success
    case failure(reason: String)

    var isSuccess: Bool {
        if case .success = self { return true }
        return false
    }
}

// MARK: - ExerciseValidator

enum ExerciseValidator {

    /// Validate user code against the exercise's expected and forbidden patterns.
    static func validate(code: String, against exercise: ExerciseModel) -> ValidationResult {
        // 1. Trim and check empty
        let trimmed = code.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmed.isEmpty else {
            return .failure(reason: "Your code is empty. Write some Swift code first!")
        }

        // 2. Check forbidden patterns (case-sensitive)
        for forbidden in exercise.forbiddenPatterns {
            let cleaned = forbidden.trimmingCharacters(in: .whitespaces)
            guard !cleaned.isEmpty else { continue }

            if trimmed.contains(cleaned) {
                return .failure(reason: "Your code should not contain \"\(cleaned)\".")
            }
        }

        // 3. Check expected patterns (case-sensitive)
        for expected in exercise.expectedPatterns {
            let cleaned = expected.trimmingCharacters(in: .whitespaces)
            guard !cleaned.isEmpty else { continue }

            if !trimmed.contains(cleaned) {
                return .failure(reason: "Missing expected pattern: \"\(cleaned)\". Check your code and try again.")
            }
        }

        // 4. All patterns matched, no forbidden found
        return .success
    }
}

import SwiftUI

// MARK: - ExerciseDetailView

struct ExerciseDetailView: View {
    @ObservedObject var state: ExerciseState
    let exercise: ExerciseModel
    let onBack: () -> Void
    let onContinue: () -> Void

    @State private var userCode: String = ""
    @State private var validationResult: ValidationResult?
    @State private var isRunning = false
    @State private var showSuccessGlow = false
    @State private var showFailureFlash = false
    @State private var xpPopAmount: Int = 0
    @State private var showXPPop = false

    private var isAlreadyCompleted: Bool {
        state.isCompleted(exercise)
    }

    // MARK: Body

    var body: some View {
        ZStack {
            Theme.deepNavy.ignoresSafeArea()

            VStack(spacing: 0) {
                topBar
                scrollContent
            }

            // Success glow overlay
            if showSuccessGlow {
                Theme.pixelGreen.opacity(0.12)
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
                    .transition(.opacity)
            }

            // Failure flash overlay
            if showFailureFlash {
                Theme.pixelRed.opacity(0.1)
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
                    .transition(.opacity)
            }

            // XP pop animation
            if showXPPop {
                xpPopView
                    .transition(.move(edge: .bottom).combined(with: .opacity))
        .onAppear {
            if userCode.isEmpty {
                userCode = exercise.starterCode
            }
        }
            if userCode.isEmpty {
                userCode = exercise.starterCode
            }
        }
    }

    // MARK: - Top Bar

    private var topBar: some View {
        HStack {
            Button(action: onBack) {
                HStack(spacing: 6) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 18, weight: .bold))
                    Text("BACK")
                        .font(Theme.pixelFont(size: 12))
                }
                .foregroundColor(Theme.whiteText)
            }

            Spacer()

            // XP Counter
            xpBadge
        }
        .padding(.horizontal, Theme.Spacing.lg)
        .frame(height: 56)
        .background(Theme.deepNavy)
        .overlay(
            Rectangle()
                .fill(Color.white.opacity(0.06))
                .frame(height: 1),
            alignment: .bottom
        )
    }

    private var xpBadge: some View {
        HStack(spacing: 4) {
            ZStack {
                Circle()
                    .fill(Theme.pixelYellow)
                    .frame(width: 16, height: 16)
                Text("✦")
                    .font(.system(size: 8))
                    .foregroundColor(Theme.deepNavy)
            }
            Text("\(state.currentXP) XP")
                .font(Theme.pixelFont(size: 12))
                .foregroundColor(Theme.pixelYellow)
        }
    }

    // MARK: - Scroll Content

    private var scrollContent: some View {
        ScrollView {
            VStack(spacing: Theme.Spacing.lg) {
                // Exercise header
                exerciseHeader

                // Instruction card
                instructionCard

                // Code editor
                CodeEditorView(
                    code: $userCode,
                    isDisabled: isAlreadyCompleted
                )

                // Run button + feedback
                actionArea

                Spacer(minLength: 40)
            }
            .padding(.horizontal, Theme.Spacing.lg)
            .padding(.top, Theme.Spacing.lg)
        }
    }

    // MARK: - Exercise Header

    private var exerciseHeader: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("EXERCISE")
                    .font(Theme.pixelFont(size: 9))
                    .tracking(3)
                    .foregroundColor(Theme.pixelOrange.opacity(0.7))

                Text(exercise.title)
                    .font(Theme.pixelFont(size: 18))
                    .foregroundColor(Theme.whiteText)
                    .lineLimit(2)
            }

            Spacer()

            // XP reward badge
            HStack(spacing: 3) {
                Text("+\(exercise.xpReward)")
                    .font(Theme.pixelFont(size: 14))
                    .foregroundColor(Theme.pixelYellow)
                Text("XP")
                    .font(Theme.pixelFont(size: 10))
                    .foregroundColor(Theme.pixelYellow.opacity(0.6))
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(
                PixelFrame(
                    baseColor: Theme.pixelYellow.opacity(0.08),
                    borderColor: Theme.pixelYellow.opacity(0.3),
                    borderWidth: 2
                )
            )
        }
    }

    // MARK: - Instruction Card

    private var instructionCard: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
            Text("OBJECTIVE")
                .font(Theme.pixelFont(size: 9))
                .tracking(2)
                .foregroundColor(Theme.pixelOrange)

            Text(exercise.description)
                .font(.system(size: 14, weight: .regular, design: .monospaced))
                .foregroundColor(Color.white.opacity(0.8))
                .lineSpacing(5)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Theme.Spacing.md)
        .background(
            PixelFrame(
                baseColor: Color.white.opacity(0.03),
                borderColor: Theme.pixelOrange.opacity(0.15),
                borderWidth: 2
            )
        )
    }

    // MARK: - Action Area

    private var actionArea: some View {
        VStack(spacing: Theme.Spacing.md) {
            if isAlreadyCompleted {
                alreadyCompletedBanner
            } else {
                // Run button
                runButton

                // Result feedback
                if let result = validationResult {
                    feedbackPanel(result)
                }

                // Continue button
                if let result = validationResult, result.isSuccess {
                    continueButton
                }
            }
        }
    }

    // MARK: - Run Button

    private var runButton: some View {
        Button(action: runValidation) {
            HStack(spacing: Theme.Spacing.xs) {
                if isRunning {
                    ProgressView()
                        .tint(Theme.deepNavy)
                        .scaleEffect(0.8)
                } else {
                    Image(systemName: "play.fill")
                        .font(.system(size: 14, weight: .bold))
                }
                Text(isRunning ? "RUNNING..." : "RUN ▶")
                    .font(Theme.pixelFont(size: 14))
            }
            .foregroundColor(Theme.deepNavy)
            .frame(maxWidth: .infinity)
            .padding(.vertical, Theme.Spacing.sm)
            .background(
                PixelFrame(
                    baseColor: Theme.pixelOrange,
                    borderColor: Theme.pixelOrange,
                    shadowColor: isRunning ? nil : Theme.pixelShadow,
                    borderWidth: 4
                )
            )
        }
        .disabled(isRunning)
        .opacity(isRunning ? 0.7 : 1.0)
    }

    // MARK: - Feedback Panel

    private func feedbackPanel(_ result: ValidationResult) -> some View {
        HStack(spacing: Theme.Spacing.sm) {
            Image(systemName: result.isSuccess ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(result.isSuccess ? Theme.pixelGreen : Theme.pixelRed)

            VStack(alignment: .leading, spacing: 2) {
                Text(result.isSuccess ? "SUCCESS!" : "NOT QUITE")
                    .font(Theme.pixelFont(size: 12))
                    .foregroundColor(result.isSuccess ? Theme.pixelGreen : Theme.pixelRed)

                if case .failure(let reason) = result {
                    Text(reason)
                        .font(.system(size: 12, weight: .regular, design: .monospaced))
                        .foregroundColor(Color.white.opacity(0.6))
                        .lineSpacing(3)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            Spacer()
        }
        .padding(Theme.Spacing.md)
        .background(
            PixelFrame(
                baseColor: result.isSuccess
                    ? Theme.pixelGreen.opacity(0.06)
                    : Theme.pixelRed.opacity(0.06),
                borderColor: result.isSuccess
                    ? Theme.pixelGreen.opacity(0.3)
                    : Theme.pixelRed.opacity(0.3),
                borderWidth: 3
            )
        )
        .transition(.opacity.combined(with: .move(edge: .top)))
    }

    // MARK: - Continue Button

    private var continueButton: some View {
        Button(action: onContinue) {
            Text("CONTINUE →")
                .font(Theme.pixelFont(size: 14))
                .foregroundColor(Theme.deepNavy)
                .frame(maxWidth: .infinity)
                .padding(.vertical, Theme.Spacing.sm)
                .background(
                    PixelFrame(
                        baseColor: Theme.pixelGreen,
                        borderColor: Theme.pixelGreen,
                        shadowColor: Theme.pixelShadow,
                        borderWidth: 4
                    )
                )
        }
        .transition(.opacity.combined(with: .move(edge: .bottom)))
    }

    // MARK: - Already Completed Banner

    private var alreadyCompletedBanner: some View {
        HStack(spacing: Theme.Spacing.sm) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Theme.pixelGreen)

            Text("COMPLETED")
                .font(Theme.pixelFont(size: 14))
                .foregroundColor(Theme.pixelGreen)

            Spacer()

            Text("+\(exercise.xpReward) XP")
                .font(Theme.pixelFont(size: 14))
                .foregroundColor(Theme.pixelYellow)
        }
        .padding(Theme.Spacing.md)
        .background(
            PixelFrame(
                baseColor: Theme.pixelGreen.opacity(0.06),
                borderColor: Theme.pixelGreen.opacity(0.3),
                borderWidth: 3
            )
        )
    }

    // MARK: - XP Pop View

    private var xpPopView: some View {
        Text("+\(xpPopAmount) XP")
            .font(Theme.pixelFont(size: 28))
            .foregroundColor(Theme.pixelYellow)
            .shadow(color: Theme.pixelYellow.opacity(0.6), radius: 12)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .allowsHitTesting(false)
    }

    // MARK: - Run Logic

    private func runValidation() {
        // Disable while running
        isRunning = true
        validationResult = nil

        // Simulate brief processing delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            let result = ExerciseValidator.validate(code: userCode, against: exercise)

            withAnimation(.easeOut(duration: 0.3)) {
                validationResult = result
                isRunning = false
            }

            if result.isSuccess {
                handleSuccess()
            } else {
                handleFailure()
            }
        }
    }

    private func handleSuccess() {
        // Haptic
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)

        // Complete exercise & XP
        state.completeExercise(exercise)

        // Green glow
        withAnimation(.easeIn(duration: 0.2)) {
            showSuccessGlow = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeOut(duration: 0.4)) {
                showSuccessGlow = false
            }
        }

        // XP pop
        xpPopAmount = exercise.xpReward
        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
            showXPPop = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeOut(duration: 0.3)) {
                showXPPop = false
            }
        }
    }

    private func handleFailure() {
        // Haptic
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)

        // Red flash
        withAnimation(.easeIn(duration: 0.1)) {
            showFailureFlash = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeOut(duration: 0.2)) {
                showFailureFlash = false
            }
        }
    }
}

// MARK: - Preview

#Preview {
    let state = ExerciseState()
    ExerciseDetailView(
        state: state,
        exercise: SampleExercises.chapter1()[0],
        onBack: {},
        onContinue: {}
    )
}

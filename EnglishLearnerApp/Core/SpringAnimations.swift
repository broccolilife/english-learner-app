import SwiftUI

// MARK: - Spring Animation Presets
/// Reusable spring animation curves for consistent motion across the app.
/// Uses iOS 17+ spring types with fallbacks.

enum AppAnimation {

    // MARK: - Springs
    static let gentleSpring = Animation.spring(duration: 0.5, bounce: 0.2)
    static let bouncySpring = Animation.spring(duration: 0.6, bounce: 0.4)
    static let snappySpring = Animation.spring(duration: 0.35, bounce: 0.15)
    static let softSpring = Animation.spring(duration: 0.7, bounce: 0.1)

    // MARK: - Semantic Animations
    static let cardFlip = Animation.spring(duration: 0.5, bounce: 0.25)
    static let listInsert = Animation.spring(duration: 0.4, bounce: 0.2)
    static let tabSwitch = Animation.spring(duration: 0.3, bounce: 0.15)
    static let celebration = Animation.spring(duration: 0.8, bounce: 0.5)
    static let progressFill = Animation.spring(duration: 1.0, bounce: 0.1)
    static let sheetPresent = Animation.spring(duration: 0.5, bounce: 0.2)

    // MARK: - Micro-interactions
    static let buttonPress = Animation.spring(duration: 0.2, bounce: 0.3)
    static let toggleSwitch = Animation.spring(duration: 0.25, bounce: 0.2)
    static let iconPop = Animation.spring(duration: 0.4, bounce: 0.5)
}

// MARK: - Animated View Modifiers

struct BounceOnAppear: ViewModifier {
    @State private var appeared = false

    func body(content: Content) -> some View {
        content
            .scaleEffect(appeared ? 1 : 0.5)
            .opacity(appeared ? 1 : 0)
            .onAppear {
                withAnimation(AppAnimation.bouncySpring) {
                    appeared = true
                }
            }
    }
}

struct PressableButton: ViewModifier {
    @State private var isPressed = false

    func body(content: Content) -> some View {
        content
            .scaleEffect(isPressed ? 0.95 : 1)
            .animation(AppAnimation.buttonPress, value: isPressed)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in isPressed = true }
                    .onEnded { _ in isPressed = false }
            )
    }
}

struct ShakeEffect: ViewModifier {
    var shakes: CGFloat

    func body(content: Content) -> some View {
        content.offset(x: sin(shakes * .pi * 2) * 6)
    }
}

// MARK: - PhaseAnimator Patterns (iOS 17+)

struct PulseEffect: ViewModifier {
    @State private var pulsing = false

    func body(content: Content) -> some View {
        content
            .scaleEffect(pulsing ? 1.05 : 1.0)
            .animation(
                .easeInOut(duration: 1.2).repeatForever(autoreverses: true),
                value: pulsing
            )
            .onAppear { pulsing = true }
    }
}

struct StreakCelebration: ViewModifier {
    let isActive: Bool

    func body(content: Content) -> some View {
        content
            .scaleEffect(isActive ? 1.2 : 1.0)
            .rotationEffect(.degrees(isActive ? 5 : 0))
            .animation(AppAnimation.celebration, value: isActive)
    }
}

// MARK: - View Extensions

extension View {
    func bounceOnAppear() -> some View {
        modifier(BounceOnAppear())
    }

    func pressable() -> some View {
        modifier(PressableButton())
    }

    func pulse() -> some View {
        modifier(PulseEffect())
    }

    func streakCelebration(_ isActive: Bool) -> some View {
        modifier(StreakCelebration(isActive: isActive))
    }

    func shake(_ shakes: CGFloat) -> some View {
        modifier(ShakeEffect(shakes: shakes))
    }
}

// MARK: - Goal-Gradient XP Bar

struct AnimatedXPBar: View {
    let progress: Double  // 0...1
    let color: Color
    @State private var animatedProgress: Double = 0
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(color.opacity(0.15))
                Capsule()
                    .fill(color)
                    .frame(width: geo.size.width * animatedProgress)
            }
        }
        .frame(height: DesignTokens.Progress.xpBarHeight)
        .clipShape(Capsule())
        .onAppear {
            withAnimation(AppAnimation.progressFill) {
                animatedProgress = progress
            }
        }
        .onChange(of: progress) { _, newValue in
            withAnimation(AppAnimation.progressFill) {
                animatedProgress = newValue
            }
        }
    }
}

// MARK: - Streak Flame Animation

struct StreakFlame: View {
    let streakDays: Int
    @State private var flameScale: CGFloat = 0
    
    var body: some View {
        HStack(spacing: DesignTokens.Spacing.xs) {
            Text("🔥")
                .font(.system(size: DesignTokens.Progress.streakFlameSize))
                .scaleEffect(flameScale)
                .onAppear {
                    withAnimation(AppAnimation.celebration) {
                        flameScale = 1
                    }
                }
            Text("\(streakDays)")
                .font(AppTypography.streakCounter)
                .foregroundStyle(DesignTokens.Colors.streakGold)
        }
    }
}

// MARK: - Correct/Wrong Answer Feedback

struct AnswerFeedback: ViewModifier {
    let isCorrect: Bool?
    
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: DesignTokens.Radius.md)
                    .stroke(feedbackColor, lineWidth: isCorrect != nil ? 3 : 0)
                    .animation(AppAnimation.snappySpring, value: isCorrect)
            )
    }
    
    private var feedbackColor: Color {
        switch isCorrect {
        case .some(true): return DesignTokens.Colors.success
        case .some(false): return DesignTokens.Colors.error
        case .none: return .clear
        }
    }
}

extension View {
    func answerFeedback(_ isCorrect: Bool?) -> some View {
        modifier(AnswerFeedback(isCorrect: isCorrect))
    }
}

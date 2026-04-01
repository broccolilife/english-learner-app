// EnglishLearnerTheme.swift — App-wide theme configuration
// Pixel+Flow — learning-focused color palette and styles

import SwiftUI

enum EnglishLearnerTheme {
    // Brand
    static let brandPrimary = Color.indigo
    static let brandSecondary = Color.teal

    // Skill badges
    static let vocabularyBadge = DesignTokens.Colors.vocabularyAccent
    static let grammarBadge = DesignTokens.Colors.grammarAccent
    static let pronunciationBadge = DesignTokens.Colors.pronunciationAccent
    static let streakFlame = DesignTokens.Colors.streakGold

    // Progress
    static let progressFill = Color.indigo
    static let progressTrack = Color.indigo.opacity(0.15)
    static let correctAnswer = DesignTokens.Colors.success
    static let incorrectAnswer = DesignTokens.Colors.error
}

struct LearnerPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body.bold())
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(
                EnglishLearnerTheme.brandPrimary.opacity(configuration.isPressed ? 0.7 : 1.0),
                in: RoundedRectangle(cornerRadius: DesignTokens.Radius.md)
            )
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == LearnerPrimaryButtonStyle {
    static var learnerPrimary: LearnerPrimaryButtonStyle { .init() }
}

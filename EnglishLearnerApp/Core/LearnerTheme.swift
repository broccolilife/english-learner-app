// LearnerTheme.swift — Semantic theme for EnglishLearnerApp
// Pixel+Muse — warm educational palette with focus-friendly colors

import SwiftUI

enum LearnerTheme {
    // MARK: - Semantic Colors
    static let correct = Color.green.opacity(0.85)
    static let incorrect = Color.red.opacity(0.75)
    static let streak = Color.orange
    static let hint = Color.yellow.opacity(0.6)
    static let cardBackground = Color(.systemBackground)
    static let surfaceElevated = Color(.secondarySystemBackground)

    // MARK: - Gradients
    static let progressGradient = LinearGradient(
        colors: [.blue.opacity(0.7), .purple.opacity(0.7)],
        startPoint: .leading, endPoint: .trailing
    )

    static let streakGradient = LinearGradient(
        colors: [.orange, .yellow],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )

    // MARK: - Shadows
    static let cardShadow = Color.black.opacity(0.08)
    static let elevatedShadow = Color.black.opacity(0.15)
}

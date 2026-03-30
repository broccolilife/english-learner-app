// Accessibility.swift — Accessibility Utilities for EnglishLearnerApp
// Pixel+Muse — Dynamic Type, VoiceOver, semantic grouping

import SwiftUI

extension View {
    /// Semantic card grouping with accessibility
    func accessibleCard(label: String, hint: String? = nil) -> some View {
        self
            .accessibilityElement(children: .combine)
            .accessibilityLabel(label)
            .accessibilityHint(hint ?? "")
            .accessibilityAddTraits(.isButton)
    }

    /// Scaled padding that respects Dynamic Type
    func scaledPadding(_ edges: Edge.Set = .all, _ length: CGFloat = DesignTokens.Spacing.md) -> some View {
        self.padding(edges, length)
    }
}

// MARK: - Reduce Motion Aware Animation

extension View {
    /// Only animate if user hasn't enabled Reduce Motion
    func animateIfAllowed<V: Equatable>(_ animation: Animation, value: V) -> some View {
        self.animation(UIAccessibility.isReduceMotionEnabled ? nil : animation, value: value)
    }
}

// ViewComponents.swift — Reusable view patterns for EnglishLearnerApp
// Pixel+Muse — quiz cards, progress sections, annotation modifier

import SwiftUI

// MARK: - Annotation Modifier

struct AnnotationModifier: ViewModifier {
    let text: String
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            content
            Text(text)
                .font(AppTypography.caption)
                .foregroundStyle(.secondary)
        }
    }
}

extension View {
    func annotation(_ text: String) -> some View {
        modifier(AnnotationModifier(text: text))
    }
}

// MARK: - App Section

struct AppSection<Content: View>: View {
    let title: String?
    @ViewBuilder let content: () -> Content

    init(_ title: String? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
            if let title {
                Text(title)
                    .font(AppTypography.sectionTitle)
                    .foregroundStyle(.secondary)
            }
            content()
        }
        .padding(DesignTokens.Spacing.md)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
    }
}

// MARK: - Quiz Card

struct QuizCard<Content: View>: View {
    let isCorrect: Bool?
    @ViewBuilder let content: () -> Content

    var body: some View {
        content()
            .padding(DesignTokens.Spacing.lg)
            .background {
                RoundedRectangle(cornerRadius: DesignTokens.Radius.lg)
                    .fill(LearnerTheme.cardBackground)
                    .shadow(color: borderColor.opacity(0.3), radius: 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: DesignTokens.Radius.lg)
                            .stroke(borderColor, lineWidth: isCorrect == nil ? 0 : 2)
                    )
            }
    }

    private var borderColor: Color {
        switch isCorrect {
        case .some(true): LearnerTheme.correct
        case .some(false): LearnerTheme.incorrect
        case .none: .clear
        }
    }
}

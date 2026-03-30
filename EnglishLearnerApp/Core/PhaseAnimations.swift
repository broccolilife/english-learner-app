// PhaseAnimations.swift — Multi-step phase animations for EnglishLearnerApp
// Pixel+Muse — learning feedback: correct/incorrect answer phases

import SwiftUI

// MARK: - Answer Feedback Phase

enum AnswerPhase: CaseIterable {
    case idle, pulse, settle

    var scale: CGFloat {
        switch self {
        case .idle: 1.0
        case .pulse: 1.15
        case .settle: 1.0
        }
    }

    var opacity: Double {
        switch self {
        case .idle: 1.0
        case .pulse: 0.85
        case .settle: 1.0
        }
    }
}

// MARK: - Streak Celebration

enum StreakPhase: CaseIterable {
    case idle, bounce, glow, settle

    var scale: CGFloat {
        switch self {
        case .idle: 1.0
        case .bounce: 1.25
        case .glow: 1.1
        case .settle: 1.0
        }
    }

    var rotation: Angle {
        switch self {
        case .idle: .zero
        case .bounce: .degrees(-5)
        case .glow: .degrees(5)
        case .settle: .zero
        }
    }
}

// MARK: - Loading Dots

struct LoadingDots: View {
    @State private var active = 0

    var body: some View {
        HStack(spacing: DesignTokens.Spacing.xs) {
            ForEach(0..<3, id: \.self) { i in
                Circle()
                    .fill(i == active ? Color.accentColor : Color.secondary.opacity(0.3))
                    .frame(width: 8, height: 8)
                    .scaleEffect(i == active ? 1.3 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.5), value: active)
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { _ in
                active = (active + 1) % 3
            }
        }
    }
}

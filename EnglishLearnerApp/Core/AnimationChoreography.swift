// AnimationChoreography.swift — Coordinated learning animations
// Pixel+Muse — goal-gradient progress, streak celebrations

import SwiftUI

// MARK: - XP Progress Bar (Goal-Gradient)

struct XPProgressBar: View {
    let current: Int
    let target: Int
    let level: String
    
    @State private var animatedProgress: Double = 0
    
    private var progress: Double {
        guard target > 0 else { return 0 }
        return min(Double(current) / Double(target), 1.0)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(level)
                    .font(.system(.caption, design: .rounded, weight: .semibold))
                    .foregroundStyle(.indigo)
                Spacer()
                Text("\(current)/\(target) XP")
                    .font(.system(.caption2, design: .rounded))
                    .foregroundStyle(.secondary)
                    .contentTransition(.numericText())
            }
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(.indigo.opacity(0.12))
                    Capsule()
                        .fill(.indigo.gradient)
                        .frame(width: geo.size.width * animatedProgress)
                }
            }
            .frame(height: 8)
        }
        .onAppear {
            withAnimation(.spring(response: 0.7, dampingFraction: 0.75).delay(0.2)) {
                animatedProgress = progress
            }
        }
        .onChange(of: current) { _, _ in
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                animatedProgress = progress
            }
        }
    }
}

// MARK: - Streak Flame

struct StreakFlame: View {
    let days: Int
    @State private var flicker = false
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "flame.fill")
                .font(.title2)
                .foregroundStyle(.orange.gradient)
                .scaleEffect(flicker ? 1.1 : 1.0)
                .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: flicker)
            
            Text("\(days)")
                .font(.system(.title3, design: .rounded, weight: .bold))
                .contentTransition(.numericText())
        }
        .onAppear { flicker = true }
    }
}

// MARK: - Answer Feedback

struct AnswerFeedback: ViewModifier {
    let isCorrect: Bool?
    
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: isCorrect != nil ? 2.5 : 0)
                    .animation(.spring(response: 0.25, dampingFraction: 0.6), value: isCorrect)
            )
            .scaleEffect(isCorrect == true ? 1.02 : (isCorrect == false ? 0.98 : 1.0))
            .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isCorrect)
    }
    
    private var borderColor: Color {
        switch isCorrect {
        case .some(true): .green
        case .some(false): .red
        case .none: .clear
        }
    }
}

// MARK: - Quiz Progress Dots

struct QuizProgressDots: View {
    let total: Int
    let current: Int
    let answers: [Bool]  // true = correct, false = incorrect for completed
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<total, id: \.self) { i in
                Circle()
                    .fill(dotColor(for: i))
                    .frame(width: i == current ? 10 : 7, height: i == current ? 10 : 7)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: current)
            }
        }
    }
    
    private func dotColor(for index: Int) -> Color {
        if index < answers.count {
            return answers[index] ? .green : .red.opacity(0.7)
        }
        return index == current ? .indigo : .gray.opacity(0.3)
    }
}

extension View {
    func answerFeedback(_ isCorrect: Bool?) -> some View {
        modifier(AnswerFeedback(isCorrect: isCorrect))
    }
}

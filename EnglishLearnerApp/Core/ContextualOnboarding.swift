// ContextualOnboarding.swift — Contextual tips for EnglishLearner
// Pixel+Muse — NNGroup: skip onboarding, teach in context

import SwiftUI

// MARK: - Tip Store

@Observable
final class LearnerTipStore {
    private var seen: Set<String> = []
    private let key = "english_learner_seen_tips"
    
    init() { seen = Set(UserDefaults.standard.stringArray(forKey: key) ?? []) }
    func shouldShow(_ id: String) -> Bool { !seen.contains(id) }
    func markSeen(_ id: String) {
        seen.insert(id)
        UserDefaults.standard.set(Array(seen), forKey: key)
    }
}

// MARK: - Learning Tips

struct LearnerTip: Identifiable {
    let id: String
    let message: String
    let icon: String
    
    static let firstQuiz = LearnerTip(
        id: "first_quiz", message: "Don't worry about mistakes — they help us find the right level for you!", icon: "lightbulb"
    )
    static let streakStart = LearnerTip(
        id: "streak_start", message: "Practice daily to build your streak! Even 5 minutes counts.", icon: "flame"
    )
    static let pronunciationHint = LearnerTip(
        id: "pronunciation", message: "Tap any word to hear its pronunciation.", icon: "speaker.wave.2"
    )
    static let reviewReminder = LearnerTip(
        id: "review", message: "Spaced repetition: we'll resurface words right before you'd forget them.", icon: "arrow.counterclockwise"
    )
}

// MARK: - Tip Banner

struct TipBanner: View {
    let tip: LearnerTip
    let store: LearnerTipStore
    @State private var visible = false
    
    var body: some View {
        if store.shouldShow(tip.id) {
            HStack(spacing: 10) {
                Image(systemName: tip.icon)
                    .font(.title3)
                    .foregroundStyle(.indigo)
                
                Text(tip.message)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Spacer(minLength: 0)
                
                Button { dismiss() } label: {
                    Image(systemName: "xmark").font(.caption).foregroundStyle(.tertiary)
                }
            }
            .padding(12)
            .background(.indigo.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
            .opacity(visible ? 1 : 0)
            .offset(y: visible ? 0 : -10)
            .onAppear {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.75).delay(0.6)) {
                    visible = true
                }
            }
        }
    }
    
    private func dismiss() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) { visible = false }
        store.markSeen(tip.id)
    }
}

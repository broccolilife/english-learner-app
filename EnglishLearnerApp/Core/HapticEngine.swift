// HapticEngine.swift — Haptic feedback for EnglishLearnerApp
// Pixel+Muse — learning-context haptics: correct, wrong, streak

import SwiftUI
import CoreHaptics

enum HapticEngine {
    static func correctAnswer() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }

    static func wrongAnswer() {
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }

    static func streak() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred(intensity: 0.9)
    }

    static func cardFlip() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }

    static func selection() {
        UISelectionFeedbackGenerator().selectionChanged()
    }

    // MARK: - CoreHaptics Celebration

    static func streakCelebration() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            let engine = try CHHapticEngine()
            try engine.start()
            let events: [CHHapticEvent] = [
                CHHapticEvent(eventType: .hapticTransient,
                    parameters: [
                        CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7),
                        CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
                    ], relativeTime: 0),
                CHHapticEvent(eventType: .hapticTransient,
                    parameters: [
                        CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                        CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)
                    ], relativeTime: 0.12),
                CHHapticEvent(eventType: .hapticContinuous,
                    parameters: [
                        CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                        CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
                    ], relativeTime: 0.2, duration: 0.25)
            ]
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch { correctAnswer() }
    }
}

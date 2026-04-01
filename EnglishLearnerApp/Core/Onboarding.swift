// Onboarding.swift — TipKit-based contextual onboarding
// Pixel+Flow — contextual tips instead of front-loaded tutorials

import SwiftUI
import TipKit

struct FirstLessonTip: Tip {
    var title: Text { Text("Start Your First Lesson") }
    var message: Text? { Text("Tap a lesson to begin learning. Each lesson builds on the last.") }
    var image: Image? { Image(systemName: "book.fill") }
}

struct StreakTip: Tip {
    @Parameter static var completedLessons: Int = 0

    var title: Text { Text("Keep Your Streak!") }
    var message: Text? { Text("Practice daily to maintain your learning streak and build lasting habits.") }
    var image: Image? { Image(systemName: "flame.fill") }

    var rules: [Rule] {
        #Rule(Self.$completedLessons) { $0 >= 3 }
    }
}

struct PronunciationTip: Tip {
    var title: Text { Text("Practice Speaking") }
    var message: Text? { Text("Tap the microphone to practice pronunciation. We'll give you instant feedback.") }
    var image: Image? { Image(systemName: "mic.fill") }
}

enum OnboardingManager {
    static func configure() {
        try? Tips.configure([
            .displayFrequency(.weekly),
            .datastoreLocation(.applicationDefault)
        ])
    }
}

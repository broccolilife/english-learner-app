// ObservableState.swift — @Observable macro patterns for EnglishLearner
// Pixel+Muse — fine-grained reactivity, iOS 17+

import SwiftUI
import Observation

// MARK: - Learning Progress

@Observable
final class LearningProgress {
    var currentLevel: Level = .beginner
    var xp: Int = 0
    var dailyStreak: Int = 0
    var wordsLearned: Int = 0
    var lessonsCompleted: Int = 0
    var lastPracticeDate: Date?
    
    var xpToNextLevel: Int {
        switch currentLevel {
        case .beginner: 500
        case .intermediate: 1200
        case .advanced: 2500
        case .fluent: Int.max
        }
    }
    
    var levelProgress: Double {
        Double(xp) / Double(xpToNextLevel)
    }
    
    var streakIsActive: Bool {
        guard let last = lastPracticeDate else { return false }
        return Calendar.current.isDateInToday(last) || Calendar.current.isDateInYesterday(last)
    }
    
    enum Level: String, CaseIterable {
        case beginner = "Beginner"
        case intermediate = "Intermediate"
        case advanced = "Advanced"
        case fluent = "Fluent"
    }
}

// MARK: - Quiz Session

@Observable
final class QuizSession {
    var questions: [QuizQuestion] = []
    var currentIndex: Int = 0
    var score: Int = 0
    var isComplete: Bool = false
    var selectedAnswer: String?
    
    var currentQuestion: QuizQuestion? {
        guard currentIndex < questions.count else { return nil }
        return questions[currentIndex]
    }
    
    var progressFraction: Double {
        guard !questions.isEmpty else { return 0 }
        return Double(currentIndex) / Double(questions.count)
    }
    
    struct QuizQuestion: Identifiable {
        let id = UUID()
        let prompt: String
        let options: [String]
        let correctAnswer: String
    }
    
    func submitAnswer(_ answer: String) {
        selectedAnswer = answer
        if answer == currentQuestion?.correctAnswer {
            score += 1
        }
    }
    
    func nextQuestion() {
        selectedAnswer = nil
        currentIndex += 1
        if currentIndex >= questions.count {
            isComplete = true
        }
    }
}

// MARK: - Environment Registration

extension EnvironmentValues {
    @Entry var learningProgress: LearningProgress = LearningProgress()
    @Entry var quizSession: QuizSession = QuizSession()
}

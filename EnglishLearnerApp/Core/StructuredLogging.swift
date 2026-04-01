// StructuredLogging.swift — OSLog structured categories for EnglishLearnerApp
// Pixel+Flow — agent-debuggable logging

import OSLog

extension Logger {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "com.broccolilife.englishlearner"

    /// Lesson progress and completion
    static let lessons = Logger(subsystem: subsystem, category: "Lessons")
    /// Vocabulary and flashcard events
    static let vocabulary = Logger(subsystem: subsystem, category: "Vocabulary")
    /// Speech recognition and pronunciation
    static let speech = Logger(subsystem: subsystem, category: "Speech")
    /// AI tutor conversations
    static let aiTutor = Logger(subsystem: subsystem, category: "AITutor")
    /// UI state transitions and navigation
    static let ui = Logger(subsystem: subsystem, category: "UI")
    /// Persistence: progress, streaks, saved words
    static let persistence = Logger(subsystem: subsystem, category: "Persistence")
    /// Network requests
    static let network = Logger(subsystem: subsystem, category: "Network")
}

# 📚 English Learner App

An iOS app for English language learning — vocabulary building, grammar practice, pronunciation training, and progress tracking.

## Features (Planned)
- 📝 Vocabulary flashcards with spaced repetition
- 🗣️ Pronunciation practice with speech recognition
- 📖 Grammar exercises and quizzes
- 📊 Progress tracking and streaks
- 🌙 Dark mode support

## Tech Stack
- SwiftUI + iOS 17+
- Speech framework for pronunciation
- CoreML for NLP features
- Swift Data for persistence

## Architecture
```
EnglishLearnerApp/
├── Core/
│   ├── DesignTokens.swift      # Colors, spacing, radii
│   ├── Typography.swift         # Type scale and styles
│   └── SpringAnimations.swift   # Reusable animation presets
├── Features/
│   ├── Vocabulary/
│   ├── Grammar/
│   └── Progress/
└── Shared/
    └── Components/
```

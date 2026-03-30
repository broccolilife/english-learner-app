// ErrorState.swift — Unified error handling for EnglishLearnerApp
// Pixel+Muse — observable error state with recovery actions

import SwiftUI

@Observable
final class ErrorState {
    var current: AppError?
    var isPresented: Bool { current != nil }

    func show(_ error: AppError) { current = error }
    func dismiss() { current = nil }
}

struct AppError: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let recovery: (() -> Void)?

    static func network(_ message: String = "Check your connection and try again.", retry: (() -> Void)? = nil) -> AppError {
        AppError(title: "Connection Error", message: message, recovery: retry)
    }

    static func generic(_ message: String = "Something went wrong.") -> AppError {
        AppError(title: "Error", message: message, recovery: nil)
    }
}

struct ErrorBanner: View {
    let error: AppError
    let onDismiss: () -> Void

    var body: some View {
        VStack(spacing: DesignTokens.Spacing.sm) {
            Text(error.title).font(AppTypography.cardTitle)
            Text(error.message).font(AppTypography.body).foregroundStyle(.secondary)
            HStack {
                if let recovery = error.recovery {
                    Button("Retry") { recovery() }
                        .buttonStyle(.borderedProminent)
                }
                Button("Dismiss") { onDismiss() }
                    .buttonStyle(.bordered)
            }
        }
        .padding(DesignTokens.Spacing.md)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
        .transition(.move(edge: .top).combined(with: .opacity))
    }
}

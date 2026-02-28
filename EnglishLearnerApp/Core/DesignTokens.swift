import SwiftUI

// MARK: - Design Tokens
/// Centralized design tokens for consistent UI across the app.
/// Based on an 8pt grid system with semantic color naming.

enum DesignTokens {

    // MARK: - Spacing (8pt grid)
    enum Spacing {
        static let xxxs: CGFloat = 2
        static let xxs: CGFloat = 4
        static let xs: CGFloat = 8
        static let sm: CGFloat = 12
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 48
        static let xxxl: CGFloat = 64
    }

    // MARK: - Corner Radii
    enum Radius {
        static let sm: CGFloat = 6
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let full: CGFloat = 9999
    }

    // MARK: - Semantic Colors
    enum Colors {
        static let primary = Color("AccentColor")
        static let secondary = Color.secondary
        static let background = Color(.systemBackground)
        static let surfacePrimary = Color(.secondarySystemBackground)
        static let surfaceSecondary = Color(.tertiarySystemBackground)
        static let textPrimary = Color(.label)
        static let textSecondary = Color(.secondaryLabel)
        static let textTertiary = Color(.tertiaryLabel)
        static let success = Color.green
        static let warning = Color.orange
        static let error = Color.red
        static let info = Color.blue

        // App-specific
        static let vocabularyAccent = Color.indigo
        static let grammarAccent = Color.teal
        static let pronunciationAccent = Color.orange
        static let streakGold = Color.yellow
    }

    // MARK: - Elevation / Shadows
    enum Elevation {
        static let shadow1 = ShadowStyle(color: .black.opacity(0.06), radius: 2, x: 0, y: 1)
        static let shadow2 = ShadowStyle(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
        static let shadow3 = ShadowStyle(color: .black.opacity(0.12), radius: 16, x: 0, y: 8)
    }

    // MARK: - Icon Sizes
    enum IconSize {
        static let sm: CGFloat = 16
        static let md: CGFloat = 24
        static let lg: CGFloat = 32
        static let xl: CGFloat = 48
    }
}

// MARK: - Shadow Style Helper
struct ShadowStyle {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
}

extension View {
    func elevation(_ style: ShadowStyle) -> some View {
        self.shadow(color: style.color, radius: style.radius, x: style.x, y: style.y)
    }
}

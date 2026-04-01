// LiquidGlass.swift — iOS 26 Liquid Glass Preparation
// Pixel+Flow — glass effects for lesson cards and floating controls

import SwiftUI

extension View {
    func glassCard(cornerRadius: CGFloat = DesignTokens.Radius.lg) -> some View {
        self
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(color: .black.opacity(0.08), radius: 4, y: 2)
    }

    func glassFAB() -> some View {
        self
            .font(.title2.bold())
            .frame(width: 56, height: 56)
            .background(.ultraThinMaterial, in: Circle())
            .shadow(color: .black.opacity(0.12), radius: 8, y: 4)
            .accessibilityAddTraits(.isButton)
    }
}

struct MeshGradientBackground: View {
    let colors: [Color]
    @State private var animating = false

    var body: some View {
        if #available(iOS 18.0, *) {
            MeshGradient(
                width: 3, height: 3,
                points: [
                    [0, 0], [0.5, 0], [1, 0],
                    [0, 0.5], [animating ? 0.6 : 0.4, 0.5], [1, 0.5],
                    [0, 1], [0.5, 1], [1, 1]
                ],
                colors: colors.count >= 9 ? Array(colors.prefix(9)) : paddedColors
            )
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                    animating.toggle()
                }
            }
            .accessibilityHidden(true)
        } else {
            LinearGradient(colors: colors.prefix(2).map { $0 }, startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
                .accessibilityHidden(true)
        }
    }

    private var paddedColors: [Color] {
        var padded = colors
        while padded.count < 9 { padded.append(padded.last ?? .clear) }
        return padded
    }
}

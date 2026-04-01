// AdaptiveLayout.swift — Adaptive layout utilities for EnglishLearnerApp
// Pixel+Flow — ViewThatFits wrappers + glass prep

import SwiftUI

struct GlassCard<Content: View>: View {
    @ViewBuilder let content: () -> Content

    var body: some View {
        content()
            .padding(DesignTokens.Spacing.md)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: DesignTokens.Radius.lg))
    }
}

struct PulsingModifier: ViewModifier {
    let isActive: Bool

    func body(content: Content) -> some View {
        if isActive {
            content
                .phaseAnimator([false, true]) { view, phase in
                    view
                        .scaleEffect(phase ? 1.08 : 1.0)
                        .opacity(phase ? 1.0 : 0.7)
                } animation: { _ in
                    .easeInOut(duration: 1.2)
                }
        } else {
            content
        }
    }
}

extension View {
    func pulsing(when active: Bool = true) -> some View {
        modifier(PulsingModifier(isActive: active))
    }
}

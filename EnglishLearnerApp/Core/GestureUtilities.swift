// GestureUtilities.swift — Reusable gesture patterns for EnglishLearnerApp
// Pixel+Muse — swipe cards, tap feedback for quiz interactions

import SwiftUI

// MARK: - Tap Bounce

struct TapBounce: ViewModifier {
    let action: () -> Void
    @State private var tapped = false

    func body(content: Content) -> some View {
        content
            .scaleEffect(tapped ? 0.88 : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.5), value: tapped)
            .onTapGesture {
                tapped = true
                action()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { tapped = false }
            }
    }
}

// MARK: - Swipe Card

struct SwipeCard: ViewModifier {
    let onLeft: (() -> Void)?
    let onRight: (() -> Void)?
    @State private var offset: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .offset(x: offset)
            .rotationEffect(.degrees(Double(offset) / 20))
            .gesture(
                DragGesture()
                    .onChanged { offset = $0.translation.width }
                    .onEnded { value in
                        if value.translation.width < -100 { onLeft?() }
                        else if value.translation.width > 100 { onRight?() }
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) { offset = 0 }
                    }
            )
    }
}

extension View {
    func tapBounce(action: @escaping () -> Void) -> some View {
        modifier(TapBounce(action: action))
    }

    func swipeCard(left: (() -> Void)? = nil, right: (() -> Void)? = nil) -> some View {
        modifier(SwipeCard(onLeft: left, onRight: right))
    }
}

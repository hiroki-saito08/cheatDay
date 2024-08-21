import SwiftUI

struct HandwrittenGoalModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("PatrickHand-Regular", size: 18)) // Ensure a handwritten look
            .foregroundColor(.black) // Ink-like color
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.7), lineWidth: 2)
                    .shadow(color: .gray.opacity(0.3), radius: 3, x: 2, y: 2)
            )
            .padding(.vertical, 5)
    }
}

extension View {
    func handwrittenStyle() -> some View {
        self.modifier(HandwrittenGoalModifier())
    }
}

import SwiftUI

struct CustomFont: ViewModifier {
    var size: CGFloat

    func body(content: Content) -> some View {
        content.font(.custom("Yomogi-Regular", size: size))
    }
}

extension View {
    func customFont(size: CGFloat) -> some View {
        self.modifier(CustomFont(size: size))
    }
}

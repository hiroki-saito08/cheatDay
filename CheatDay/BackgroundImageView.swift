import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
        ZStack {
            // 背景画像を全画面に設定
            Image("backgroundImage")
                .resizable() // 画像をリサイズ可能に
                .scaledToFill() // 画面全体にフィット
                .edgesIgnoringSafeArea(.all) // 全画面に表示
            // 他のビューをこの上に重ねる
            ContentView() // ここに実際のコンテンツを追加
        }
    }
}

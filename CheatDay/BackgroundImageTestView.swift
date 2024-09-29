import SwiftUI

struct BackgroundImageTestView: View {
    var body: some View {
        ZStack {
            // 背景画像を表示
            if let _ = UIImage(named: "backgroundImage") {
                Image("backgroundImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300) // 小さなサイズで表示して確認しやすく
                    .clipped()
            } else {
                // 背景画像が読み込めなかった場合の代替テキスト
                Text("背景画像が読み込めませんでした")
                    .font(.title)
                    .foregroundColor(.red)
            }
        }
    }
}

struct BackgroundImageTestView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImageTestView()
    }
}

import SwiftUI

struct FAQView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                FAQItem(question: "このアプリで「チートデイ」とは何ですか？", answer: "「チートデイ」は、特定の習慣を一時的に休む日です。無理なく習慣を続けやすくします。")
                FAQItem(question: "目標を設定するにはどうすればよいですか？", answer: "画面の右上にある「+」ボタンをタップして、目標のタイトルや目的、サイクル日数を入力し、「保存」を押すと目標が設定されます。")
                FAQItem(question: "設定した目標を編集または削除できますか？", answer: "はい、設定した目標を編集または削除することができます。目標の一覧から、編集したい目標を長押しすると、編集または削除のオプションが表示されます。")
                FAQItem(question: "通知を受け取る方法を教えてください。", answer: "設定画面で「通知を有効にする」をオンにすると、通知が届くようになります。")
                FAQItem(question: "チートデイのサイクル日数を変更できますか？", answer: "目標の編集画面で、いつでもチートデイのサイクル日数を変更できます。")
                FAQItem(question: "データのバックアップは自動的に行われますか？", answer: "現在はデバイスにデータが保存されますが、将来的にクラウドバックアップ機能を追加する予定です。")
                FAQItem(question: "データをリセットする方法はありますか？", answer: "設定画面の「ストレージとデータ」で「キャッシュをクリアする」または「データをリセットする」オプションを選択できます。注意: データをリセットすると、すべての目標と進捗が削除されますのでご注意ください。")
            }
            .padding()
        }
        .navigationBarTitle("よくある質問 (FAQ)", displayMode: .inline)
    }
}

struct FAQItem: View {
    let question: String
    let answer: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(question)
                .font(.yomogiHeadline()) // Applying custom font for the question
            Text(answer)
                .font(.yomogiBody()) // Applying custom font for the answer
                .foregroundColor(.secondary)
        }
    }
}

import SwiftUI

struct TermsOfServiceView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("利用規約")
                    .font(.yomogiTitle()) // Applying custom font for the title
                    .padding(.bottom, 8)
                
                TermsOfServiceSection(
                    title: "1. 利用条件",
                    content: "本アプリを使用するには、ユーザーはこれらの利用規約に同意する必要があります。アプリをインストールし、使用することで、これらの利用規約に同意したものとみなされます。"
                )
                
                TermsOfServiceSection(
                    title: "2. 禁止事項",
                    content: "ユーザーは、以下の行為を行ってはなりません:\n\n1. 不正アクセスまたはハッキング\n2. アプリのリバースエンジニアリング\n3. 他のユーザーのデータを収集、使用すること"
                )
                
                TermsOfServiceSection(
                    title: "3. 免責事項",
                    content: "本アプリは、現状のまま提供され、特定の目的に対する適合性や、バグのない運用を保証するものではありません。"
                )
                
                TermsOfServiceSection(
                    title: "4. 知的財産権",
                    content: "本アプリに含まれるすべてのコンテンツ、テキスト、画像、ロゴは、当社またはライセンサーの所有物であり、著作権法によって保護されています。"
                )
                
                TermsOfServiceSection(
                    title: "5. 規約の変更",
                    content: "当社は、事前の通知なく、必要に応じてこれらの利用規約を変更する権利を有します。利用規約が変更された場合、変更後にアプリを使用することで、ユーザーは変更に同意したものとみなされます。"
                )
                
                TermsOfServiceSection(
                    title: "6. サービスの終了",
                    content: "当社は、事前の通知なく、本アプリの提供を中止または終了する権利を有します。"
                )
            }
            .padding()
        }
        .navigationBarTitle("利用規約", displayMode: .inline)
    }
}

struct TermsOfServiceSection: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.yomogiHeadline()) // Applying custom font for section titles
                .padding(.bottom, 4)
            Text(content)
                .font(.yomogiBody()) // Applying custom font for the content
                .foregroundColor(.secondary)
        }
    }
}

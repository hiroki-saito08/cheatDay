import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("プライバシーポリシー")
                    .font(.yomogiTitle()) // Applying custom font for the title
                    .padding(.bottom, 8)
                
                PrivacyPolicySection(
                    title: "1. ユーザー情報の収集",
                    content: "本アプリは、ユーザーの個人情報を一切収集しませんが、広告配信のためにGoogle AdMobを使用しています。Google AdMobは、広告の最適化およびパーソナライズのために、一部のデータ（広告識別子など）を収集する場合があります。"
                )
                
                PrivacyPolicySection(
                    title: "2. データの使用",
                    content: "本アプリでは、広告配信に関するデータはGoogle AdMobを通じて使用されます。これらのデータは、本アプリでは直接収集せず、Googleの広告ネットワークが取り扱います。"
                )
                
                PrivacyPolicySection(
                    title: "3. データの保護",
                    content: "Google AdMobによって収集されたデータは、Googleのプライバシーポリシーに基づいて保護されます。詳細は、Googleのプライバシーポリシーをご確認ください。"
                )
                
                PrivacyPolicySection(
                    title: "4. 第三者への提供",
                    content: "本アプリは、ユーザーの個人情報を収集していないため、第三者への提供は行いません。ただし、Google AdMobを通じて一部のデータが広告パートナーと共有される場合があります。"
                )
                
                PrivacyPolicySection(
                    title: "5. プライバシーポリシーの変更",
                    content: "本アプリのプライバシーポリシーは、必要に応じて更新されることがあります。変更が行われた場合は、アプリ内で通知します。"
                )
                
                Link("Googleのプライバシーポリシーはこちら", destination: URL(string: "https://policies.google.com/privacy")!)
                    .font(.yomogiBody()) // Custom font for the link
                    .foregroundColor(.blue)
            }
            .padding()
        }
        .navigationBarTitle("プライバシーポリシー", displayMode: .inline)
    }
}


struct PrivacyPolicySection: View {
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

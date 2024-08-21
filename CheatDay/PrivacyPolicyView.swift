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
                    content: "本アプリは、ユーザーの個人情報を一切収集しません。"
                )
                
                PrivacyPolicySection(
                    title: "2. データの使用",
                    content: "本アプリは、ユーザーの個人情報を収集しないため、データの使用も行いません。"
                )
                
                PrivacyPolicySection(
                    title: "3. データの保護",
                    content: "ユーザーの個人情報を収集しないため、データの保護は不要です。"
                )
                
                PrivacyPolicySection(
                    title: "4. 第三者への提供",
                    content: "本アプリは、ユーザー情報を収集していないため、第三者への提供も行いません。"
                )
                
                PrivacyPolicySection(
                    title: "5. プライバシーポリシーの変更",
                    content: "本アプリのプライバシーポリシーは、必要に応じて更新されることがあります。変更が行われた場合は、アプリ内で通知します。"
                )
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
